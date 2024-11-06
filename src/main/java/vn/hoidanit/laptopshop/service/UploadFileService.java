package vn.hoidanit.laptopshop.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadFileService {

    private final ServletContext servletContext;

    public UploadFileService(ServletContext servletContext) {
        this.servletContext = servletContext;

    }

    public String handleSaveFileUpload(MultipartFile file, String targetFolder) {

        if (file == null || file.isEmpty()) {
            return "";
        }

        return saveFileToServer(file, targetFolder);

    }

    public String handleUpdateAvatar(MultipartFile file, String targetFolder, String oldAvatar) {

        String rootPath = this.servletContext.getRealPath("/resources/images");

        if (file == null || file.isEmpty()) {
            return "";
        }

        if (oldAvatar != null && !oldAvatar.equals("default.jpg")) {

            File oldFile = new File(rootPath + File.separator + targetFolder + oldAvatar);
            oldFile.delete();
        }

        return saveFileToServer(file, targetFolder);

    }

    private String saveFileToServer(MultipartFile file, String targetFolder) {

        String finalName = "";

        byte[] bytes;
        try {
            bytes = file.getBytes();

            String rootPath = this.servletContext.getRealPath("/resources/images");

            File dir = new File(rootPath + File.separator + targetFolder);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            File serverFile = new File(dir.getAbsolutePath() + File.separator +
                    +System.currentTimeMillis() + "-" + file.getOriginalFilename());
            finalName = serverFile.getName();

            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return finalName;

    }

}
