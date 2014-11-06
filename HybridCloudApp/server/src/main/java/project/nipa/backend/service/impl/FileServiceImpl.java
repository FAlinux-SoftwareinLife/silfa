package project.nipa.backend.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.nipa.backend.domain.File;
import project.nipa.backend.domain.Profile;
import project.nipa.backend.dto.FileDto;
import project.nipa.backend.repository.FileRepository;
import project.nipa.backend.service.FileService;
import project.nipa.backend.service.ProfileService;

@Service
public class FileServiceImpl implements FileService{

	@Autowired private FileRepository fileRepository;
	@Autowired private ProfileService profileService;
	
	@Override
	public void insertFile(FileDto fileDto) {
		File file = new File(fileDto);
		Profile user = profileService.findByUserId(fileDto.getUserId());
		file.setProfile(user);
		fileRepository.saveAndFlush(file);
	}

	@Override
	public File getFiles(String fileId) {
		return fileRepository.findOne(fileId); 
	}

	@Override
	public void deleteFile(String fileId) {
		fileRepository.delete(fileId);
	}

	@Override
	public void updateFile(FileDto fileDto, String fileId) {
		File file = fileRepository.findByFileId(fileId);
		file.setFileName(fileDto.getFileName());
		file.setModifiedDate(fileDto.getModifiedDate());
		file.setThumbnail(fileDto.getThumbnail());
		file.setFileType(fileDto.getFileType());
		fileRepository.saveAndFlush(file);
	}
	
}
