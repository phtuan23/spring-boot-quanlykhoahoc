package com.upload;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileStoreServiceImp implements FilesStorageService {
	private final String path = "D:\\workspace-eclipse\\BaiTapLonSH\\src\\main\\resources\\static\\uploads";
	private final Path root = Paths.get(path);

	@Override
	public void save(MultipartFile file) {
		try {
			File f = new File(path);
			File dest = new File(f.getAbsolutePath() + "\\" + file.getOriginalFilename());
			if (!dest.exists()) {
				Files.copy(file.getInputStream(), this.root.resolve(file.getOriginalFilename()));				
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("lỗi : " + e.getMessage());
		}
	}
}
