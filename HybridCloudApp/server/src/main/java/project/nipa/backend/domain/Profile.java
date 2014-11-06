package project.nipa.backend.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Profile implements Serializable{
	private static final long serialVersionUID = -5410149072625484260L;

	@Id
	@Column(nullable=false)
	private String userId;
	
	private String photo;
	private String gender;
	private String email;
	private String language;
	
	@Column(columnDefinition="text")
	private String authorize;
	
	@OneToMany(mappedBy="profile", cascade=CascadeType.ALL)
	private List<File> files = new ArrayList<File>();
	
}
