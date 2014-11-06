package project.nipa.backend.exception;

import lombok.Getter;

public class NipaException extends Exception {
	private static final long serialVersionUID = 6649087185411313987L;
	
	@Getter
	private int errorCode;
	@Getter
	private String message;
	
	
	public NipaException(int errorCode, String message) {
		this.errorCode = errorCode;
		this.message = message;
	}

}
