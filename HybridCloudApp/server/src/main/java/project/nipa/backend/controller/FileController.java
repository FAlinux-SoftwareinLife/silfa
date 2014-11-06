package project.nipa.backend.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.nipa.backend.domain.File;
import project.nipa.backend.dto.FileDto;
import project.nipa.backend.service.FileService;

@Controller
public class FileController {

	static final String JSONVIEW = "jsonView";
	
	@Autowired private FileService fileService;
	
	@RequestMapping(value="files", method=RequestMethod.POST)
	public String insertFile(FileDto fileDto){
		fileService.insertFile(fileDto);
		return JSONVIEW;
	}
	
	@RequestMapping(value="files/{fileId}", method=RequestMethod.GET)
	public String getFile(@PathVariable String fileId,ModelMap map){
		File files = fileService.getFiles(fileId);
		map.put("data", files);
		return JSONVIEW;
	}
	
	@RequestMapping(value="files/{fileId}", method=RequestMethod.DELETE)
	public String deleteFile(@PathVariable String fileId){
		fileService.deleteFile(fileId);
		return JSONVIEW;
	}
	
	@RequestMapping(value="files/{fileId}", method=RequestMethod.PUT)
	public String updateFile(@PathVariable String fileId,@RequestBody FileDto fileDto){
		fileService.updateFile(fileDto,fileId);
		return JSONVIEW;
	}
}
