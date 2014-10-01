package project.nipa.backend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.nipa.backend.domain.User;
import project.nipa.backend.repository.UserRepository;
import project.nipa.backend.service.UserService;

@Service
public class UserServiceImpl implements UserService{

	@Autowired private UserRepository userRepository;
	
	@Override
	public void insertUserData(User user) {
		userRepository.saveAndFlush(user);
	}

	@Override
	public User getUSerData(Long number) {
		return userRepository.findOne(number);
	}

	@Override
	public void deleteUserData(Long number) {
		userRepository.delete(number);
	}

	@Override
	public void updateUserData(Long number, User user) {
		User userData = userRepository.findByNumber(number);
		userData.setId(user.getId());
		userData.setEmail(user.getEmail());
		userData.setAuthorization(user.getAuthorization());
		userData.setPhoto(user.getPhoto());
		
		userRepository.saveAndFlush(userData);
	}

}
