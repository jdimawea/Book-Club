package com.jonathandimawea.bookclub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.jonathandimawea.bookclub.models.Book;
import com.jonathandimawea.bookclub.models.LoginUser;
import com.jonathandimawea.bookclub.models.User;
import com.jonathandimawea.bookclub.services.BookService;
import com.jonathandimawea.bookclub.services.UserService;

@Controller
public class BookController {

	@Autowired
	private BookService bookService;

	@Autowired
	private UserService userService;

	// create
	@GetMapping("/books/new")
	public String createbookForm(@ModelAttribute("book") Book book, Model model, HttpSession session) {

		if (session.getAttribute("userId") == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "redirect:/";
		} else {
			return "createBook.jsp";
		}
	}

	@PostMapping("/books/new")
	public String processbookForm(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model,
			HttpSession session) {

		if (session.getAttribute("userId") == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "redirect:/";
		}
		if (result.hasErrors()) {
			return "createBook.jsp";
		} else {
			User user = userService.oneUser((Long) session.getAttribute("userId"));
			book.setUser(user);
			bookService.saveBook(book);
			return "redirect:/books";
		}
	}

	// show one
	@GetMapping("/books/{id}")
	public String bookDetails(@PathVariable("id") Long id, Model model, HttpSession session) {

		if (session.getAttribute("userId") == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "redirect:/";
		} else {
			Book book = bookService.oneBook(id);
			User user = userService.oneUser((Long) session.getAttribute("userId"));
			model.addAttribute("userId", user.getId());
			model.addAttribute("book", book);
			return "showOneBook.jsp";
		}
	}

	// edit
	@GetMapping("/books/{id}/edit")
	public String editbookForm(@PathVariable("id") Long id, Model model, HttpSession session) {

		Book book = bookService.oneBook(id);
		if (session.getAttribute("userId") == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "redirect:/";
		}
		if (session.getAttribute("userId") != (book.getUser().getId())) {
			User user = userService.oneUser((Long) session.getAttribute("userId"));
			List<Book> allBooks = bookService.allBooks();
			model.addAttribute("allBooks", allBooks);
			model.addAttribute("user", user);
			return "dashboard.jsp";
		}
		model.addAttribute("book", book);
		return "editBook.jsp";
	}

	@PutMapping("/books/{id}/edit")
	public String processbookForm(@Valid @ModelAttribute("book") Book book, BindingResult result, HttpSession session) {

		if (result.hasErrors()) {
			return "editBook.jsp";
		}
		User user = userService.oneUser((Long) session.getAttribute("userId"));
		book.setUser(user);
		bookService.saveBook(book);
		return "redirect:/books";
	}

	// show all
	@GetMapping("/books")
	public String dashboard(Model model, HttpSession session) {
		if (session.getAttribute("userId") == null) {
			model.addAttribute("loginUser", new LoginUser());
			return "redirect:/";
		}
		User user = userService.oneUser((Long) session.getAttribute("userId"));
		List<Book> allBooks = bookService.allBooks();
		model.addAttribute("allBooks", allBooks);
		model.addAttribute("user", user);
		return "dashboard.jsp";
	}

	// delete
	@DeleteMapping("/delete/{id}")
	public String deleteBook(@PathVariable("id") Long id) {
		bookService.deleteBook(id);
		return "redirect:/books";
	}

}
