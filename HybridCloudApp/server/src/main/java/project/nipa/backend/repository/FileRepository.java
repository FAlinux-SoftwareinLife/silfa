package project.nipa.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import project.nipa.backend.domain.File;

public interface FileRepository extends JpaRepository<File, String>{
	File findByFileId(String fileId);

}
