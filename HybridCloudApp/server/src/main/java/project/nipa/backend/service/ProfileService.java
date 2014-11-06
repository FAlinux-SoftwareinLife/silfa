package project.nipa.backend.service;

import project.nipa.backend.domain.Profile;

public interface ProfileService {
	void insertUserData(Profile profile);
	void deleteUserData(String userId);
	void updateUserData(String userId, Profile profile);
	Profile getUserData(String userId);
	Profile findByUserId(String userId);
}
