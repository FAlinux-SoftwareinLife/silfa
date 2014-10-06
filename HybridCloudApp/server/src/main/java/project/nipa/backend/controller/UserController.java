package project.nipa.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.nipa.backend.domain.User;
import project.nipa.backend.service.UserService;

@Controller
public class UserController {
	
	static final String JSONVIEW = "jsonView";

	@Autowired private UserService userService;
	
	@RequestMapping(value={"/","test"}, method=RequestMethod.GET)
	public String test(){
		return "test";
	}
	
	@RequestMapping(value="users", method=RequestMethod.POST)
	public String insertUserData(User user){
		userService.insertUserData(user);
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{number}", method=RequestMethod.GET)
	public String getUserData(@PathVariable Long number,ModelMap map){
		User userData = userService.getUSerData(number);
		map.put("data", userData);
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{number}", method=RequestMethod.DELETE)
	public String deleteUserData(@PathVariable Long number){
		userService.deleteUserData(number);
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{number}", method=RequestMethod.PUT)
	public String updateUserData(@PathVariable Long number,@RequestBody User user){
		userService.updateUserData(number,user);
		return JSONVIEW;
	}
}
