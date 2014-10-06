package project.nipa.backend.domain;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class User implements Serializable{
	private static final long serialVersionUID = 6495748315333870751L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long number;
	
	private String id;
	private String email;
	private String authorization;
	private String photo;
}
