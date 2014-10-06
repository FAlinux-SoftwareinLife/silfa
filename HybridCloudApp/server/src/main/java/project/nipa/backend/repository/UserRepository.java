package project.nipa.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import project.nipa.backend.domain.User;

public interface UserRepository extends JpaRepository<User, Long>{

	User findByNumber(Long number);

}
