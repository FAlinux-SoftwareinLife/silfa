package project.nipa.backend.dto;

import java.io.Serializable;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class FileDto implements Serializable{
	private static final long serialVersionUID = -129757169126445965L;

	private String userId;
	private String fileId;
	private String fileName;
	private String modifiedDate;
	private String thumbnail;
	private String fileType;
}
