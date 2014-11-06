package project.nipa.backend.service;

import project.nipa.backend.domain.File;
import project.nipa.backend.dto.FileDto;

public interface FileService {
	void insertFile(FileDto fileDto);
	File getFiles(String fileId);
	void deleteFile(String fileId);
	void updateFile(FileDto fileDto, String fileId);

}
