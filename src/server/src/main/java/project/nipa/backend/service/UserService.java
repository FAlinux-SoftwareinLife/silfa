package project.nipa.backend.service;

import project.nipa.backend.domain.User;

public interface UserService {

	void insertUserData(User user);

	User getUSerData(Long number);

	void deleteUserData(Long number);

	void updateUserData(Long number, User user);
}
