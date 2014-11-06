package project.nipa.backend.controller.advice;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import project.nipa.backend.exception.NipaException;

@ControllerAdvice
public class NipaExceptionAdvice {
	
	@ExceptionHandler(NipaException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	public ModelAndView whenAccessDenied(HttpServletRequest req, Exception e) {
		NipaException exception = (NipaException) e;
		ModelAndView mav = new ModelAndView("jsonView");
        mav.addObject("errorCode", exception.getErrorCode());
        mav.addObject("message", exception.getMessage());
        return mav;
	}
}
