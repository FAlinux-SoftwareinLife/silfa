package project.nipa.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import project.nipa.backend.domain.Profile;

public interface ProfileRepository extends JpaRepository<Profile, String>{
	Profile findByUserId(String userId);


}
