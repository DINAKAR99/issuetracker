package in.gov.cgg.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileUploadUtil {

  private static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);

  public static String uploadFile(MultipartFile file, String uploadPath) {
    String filePath = "";
    LocalDateTime localDateTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
    String formatDateTime = localDateTime.format(formatter);

    String fileName = FilenameUtils.removeExtension(file.getOriginalFilename());
    String fileExtension = FilenameUtils.getExtension(
      file.getOriginalFilename()
    );

    if (!file.isEmpty()) {
      File dir = new File(uploadPath);
      if (!dir.exists()) {
        dir.mkdirs();
      }
      logger.info("Filename in fileUploadUtil {}", fileName);
      logger.info(
        "Extension is  in fileUploadUtil {} {} {} {} " + uploadPath,
        fileName,
        formatDateTime,
        fileExtension
      );
      filePath = fileName + formatDateTime + "." + fileExtension;
      try (
        BufferedOutputStream bout = new BufferedOutputStream(
          new FileOutputStream(uploadPath + filePath)
        );
      ) {
        byte barr[] = file.getBytes();
        bout.write(barr);
        bout.flush();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return filePath;
  }

  private static final String ALLOWED_CHARS = "[^a-zA-Z0-9-_]"; // Only allow letters, numbers, -, _

  public static String uploadFile2(
    MultipartFile file,
    String uploadPath,
    String ticketNumber
  ) {
    if (file == null || file.isEmpty()) {
      throw new IllegalArgumentException("File cannot be empty!");
    }

    // Format timestamp
    String formatDateTime = LocalDateTime
      .now()
      .format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

    // Sanitize filename
    String originalFileName = file.getOriginalFilename();
    String fileName = sanitizeFileName(
      FilenameUtils.removeExtension(originalFileName)
    );
    String fileExtension = FilenameUtils.getExtension(originalFileName);

    // Ensure the upload directory exists
    uploadPath = uploadPath + ticketNumber + "/";
    File dir = new File(uploadPath);
    if (!dir.exists()) {
      dir.mkdirs();
    }

    // Construct new file name
    String safeFileName = fileName + "_" + formatDateTime + "." + fileExtension;
    String finalPath = uploadPath + safeFileName;

    try {
      // Save file
      Files.write(
        Paths.get(finalPath),
        file.getBytes(),
        StandardOpenOption.CREATE
      );
    } catch (IOException e) {
      throw new RuntimeException("File upload failed", e);
    }

    System.out.println("File uploaded to: " + finalPath);
    return finalPath;
  }

  // Function to sanitize filenames
  private static String sanitizeFileName(String fileName) {
    return fileName.replaceAll(ALLOWED_CHARS, "_"); // Replace special characters with "_"
  }
}
