package com.upload;


import org.springframework.web.multipart.MultipartFile;

public interface FilesStorageService {
	public boolean save(MultipartFile file);
}
