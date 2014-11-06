package project.nipa.backend.domain;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import project.nipa.backend.dto.FileDto;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class File implements Serializable{
	private static final long serialVersionUID = -6380551685916668240L;

	@Id
	@Column(unique=true, nullable=false)
	private String fileId;
	
	private String fileName;
	private String modifiedDate;
	private String thumbnail;
	private String fileType;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="userId")
	@JsonIgnore
	private Profile profile;
	
	public File(FileDto dto){
		this.fileId =dto.getFileId();
		this.fileName = dto.getFileName();
		this.modifiedDate = dto.getModifiedDate();
		this.thumbnail = dto.getThumbnail();
		this.fileType = dto.getFileType();
	}
}
