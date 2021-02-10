package com.blakeburns.javabeltexam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.blakeburns.javabeltexam.models.Show;
import com.blakeburns.javabeltexam.models.User;
import com.blakeburns.javabeltexam.services.ShowService;
import com.blakeburns.javabeltexam.services.UserService;
import com.blakeburns.javabeltexam.validator.UserValidator;

@Controller
public class MainController {
	private final UserService userService;
	private final UserValidator userValidator;
	private final ShowService cS;

	public MainController(UserService userService, UserValidator userValidator, ShowService cS) {
		this.userService = userService;
		this.userValidator = userValidator;
		this.cS = cS;
	}

	@RequestMapping("/")
	public String index(@ModelAttribute("user") User user) {
		return "index.jsp";
	}

	@RequestMapping(value = "/registration", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "index.jsp";
		}
		User u = userService.registerUser(user);
		session.setAttribute("userId", u.getId());
		return "redirect:/shows";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		boolean isAuthenticated = userService.authenticateUser(email, password);
		if (isAuthenticated) {
			User u = userService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/shows";
		} else {
			model.addAttribute("user", new User());
			model.addAttribute("error", "Invalid Email/Password. Please try again.");
			return "index.jsp";
		}
	}

	@RequestMapping("/shows")
	public String homepage(HttpSession session, Model model) {

		if (session.getAttribute("userId") != null) {
			// get user from session, save them in the model and return the home page
			Long userId = (Long) session.getAttribute("userId");
			User u = userService.findUserById(userId);

			// model pass u user to jsp in order to display current user login name
			model.addAttribute("user", u);

			// render shows in table

			List<Show> showList = cS.findAllCourses();
			model.addAttribute("shows", showList);
			return "homePage.jsp";

		} else {
			System.out.println("You have not logged in");
			return "redirect:/";
		}
	}

	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping("/shows/new")
	public String showCreation(@ModelAttribute("show") Show myShow) {
		return "show.jsp";
	}

	@PostMapping("/shows/new")
	public String createShow(@Valid @ModelAttribute("show") Show myShow, BindingResult result) {
		if (result.hasErrors()) {

			System.out.println("Error while creating show");
			return "show.jsp";
		} else {
			System.out.println("------- Create course ------");
			cS.createCourse(myShow);
			return "redirect:/shows";
		}
	}

	@RequestMapping("shows/{id}")
	public String displayShow(@PathVariable("id") Long myId, Model model, HttpSession session) {
		Show myShow = cS.findCourseById(myId);
		model.addAttribute("show", myShow);

		List<User> users = myShow.getUsers();
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		model.addAttribute("currentUser",u);
		System.out.println("--get id-- "+u.getId());
		return "showinfo.jsp";
	}

	@RequestMapping("/shows/add/{id}")
	public String addShow(@PathVariable("id") Long myId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		Show show = cS.findCourseById(myId);
		
		u.getCourses().add(show);
		userService.updateUser(u);
		
		
		return "redirect:/shows";
	}

	
	@RequestMapping("/shows/{id}/edit")
	public String editPage(@ModelAttribute("show") Show myShow, @PathVariable("id") Long myId, Model model) {
		Show show = cS.findCourseById(myId);
		model.addAttribute("course", show);
		return "edit.jsp";
	}

	@PostMapping("/shows/update")
	public String updateShow(@Valid @ModelAttribute("show") Show myShow, BindingResult result) {
		if (result.hasErrors()) {
			return "edit.jsp";
		} else {
			List<User> myStudents =myShow.getUsers();
			System.out.println("--- all students --- "+ myStudents);
			cS.updateCourse(myShow);
			
			return "redirect:/shows";
		}
	}

	@RequestMapping("/shows/delete/{id}")
	public String deleteShow(@PathVariable("id") Long id) {
		Show myShow = cS.findCourseById(id);
		if (myShow != null) {
			cS.deleteCourse(myShow);
			return "redirect:/shows";
		} else {
			System.out.println("Show doesn't exist");
			return "redirect:/shows";
		}

	}

	@RequestMapping("/shows/{id}/remove")
	public String removeUserFromShow(@PathVariable("id") Long myId, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User u = userService.findUserById(userId);
		Show show = cS.findCourseById(myId);
		
		u.getCourses().remove(show);
		userService.updateUser(u);
		
		return "redirect:/shows";
	}
	
	@RequestMapping("/shows/{id}/add")
		public String addUserToShow(@PathVariable("id") Long myId, Model model, HttpSession session) {
			Long userId = (Long) session.getAttribute("userId");
			User u = userService.findUserById(userId);
			Show show = cS.findCourseById(myId);
			
			u.getCourses().add(show);
			userService.updateUser(u);
			
			return "redirect:/shows";
		}
	
	
}