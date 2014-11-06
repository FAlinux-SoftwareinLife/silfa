package project.nipa.backend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.nipa.backend.domain.Profile;
import project.nipa.backend.repository.ProfileRepository;
import project.nipa.backend.service.ProfileService;

@Service
public class ProfileServiceImpl implements ProfileService{

	@Autowired private ProfileRepository profileRepository;
	
	@Override
	public void insertUserData(Profile profile) {
		profileRepository.saveAndFlush(profile);
	}

	@Override
	public Profile getUserData(String userId) {
		return profileRepository.findOne(userId);
	}

	@Override
	public void deleteUserData(String userId) {
		profileRepository.delete(userId);
	}

	@Override
	public void updateUserData(String userId, Profile user) {
		Profile userData = profileRepository.findByUserId(userId);
		userData.setPhoto(user.getPhoto());
		userData.setGender(user.getGender());
		userData.setEmail(user.getEmail());
		userData.setLanguage(user.getLanguage());
		userData.setAuthorize(user.getAuthorize());
		
		profileRepository.saveAndFlush(userData);
	}

	@Override
	public Profile findByUserId(String userId) {
		return profileRepository.findByUserId(userId);
	}

}
