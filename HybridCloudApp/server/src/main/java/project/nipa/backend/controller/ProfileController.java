package project.nipa.backend.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.nipa.backend.domain.Profile;
import project.nipa.backend.exception.NipaException;
import project.nipa.backend.service.ProfileService;

@Controller
public class ProfileController {

	
	static final String JSONVIEW = "jsonView";

	@Autowired private ProfileService profileService;
	
	@RequestMapping(value={"/","test"}, method=RequestMethod.GET)
	public String test(){
		return "test";
	}
	
	@RequestMapping(value="users", method=RequestMethod.POST)
	public String insertUserData(Profile profile, ModelMap map) throws NipaException{
		try {
			profileService.insertUserData(profile);
			map.put("result", "success");
		} catch (Exception e) {
			map.put("result", "failed");
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{userId}", method=RequestMethod.GET)
	public String getUserData(@PathVariable String userId,ModelMap map){
		
		Profile userData = profileService.getUserData(userId);
		map.put("data", userData);
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{userId}", method=RequestMethod.DELETE)
	public String deleteUserData(@PathVariable String userId){
		profileService.deleteUserData(userId);
		return JSONVIEW;
	}
	
	@RequestMapping(value="users/{userId}", method=RequestMethod.PUT)
	public String updateUserData(@PathVariable String userId,@RequestBody Profile profile){
		profileService.updateUserData(userId,profile);
		return JSONVIEW;
	}
}
