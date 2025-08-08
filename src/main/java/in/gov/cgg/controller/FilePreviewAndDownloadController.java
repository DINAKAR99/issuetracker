package in.gov.cgg.controller;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FilePreviewAndDownloadController {

	
	@Value("${undertaking.upload.path}")
	private String homePath;
	
		@GetMapping(value="/preview/{fileName}")
		public @ResponseBody ResponseEntity<Resource> filePreview(HttpServletRequest request,	@PathVariable String fileName,
							AntPathMatcher pathMatcher) throws IOException {
			File file = new File(homePath+fileName);
	        HttpHeaders header = new HttpHeaders();
	        header.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename="+fileName+"");
	        header.add("Cache-Control", "no-cache, no-store, must-revalidate");
	        header.add("Pragma", "no-cache");
	        header.add("Expires", "0");

	        Path path = Paths.get(file.getAbsolutePath());
	        ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));

	        return ResponseEntity.ok()
	                .headers(header)
	                .contentLength(file.length())
	                .contentType(MediaType.parseMediaType("application/octet-stream"))
	                .body(resource);
 
		}
		
		
		static final byte[] blankPngBytes =new byte[]{(byte) 0x89, (byte) 0x50, (byte) 0x4e, (byte) 0x47, 0xd, 0xa, (byte) 0x1a, 0xa, 0x0, 0x0, 0x0, 0xd, (byte) 0x49, (byte) 0x48, (byte) 0x44, (byte) 0x52, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x1, 0x8, 0x4, 0x0, 0x0, 0x0, (byte) 0xb5, (byte) 0x1c, 0xc, 0x2, 0x0, 0x0, 0x0, 0xb, (byte) 0x49, (byte) 0x44, (byte) 0x41, (byte) 0x54, (byte) 0x78, (byte) 0xda, (byte) 0x63, (byte) 0x64, (byte) 0x60, 0x0, 0x0, 0x0, 0x6, 0x0, 0x2, (byte) 0x30, (byte) 0x81, (byte) 0xd0, (byte) 0x2f, 0x0, 0x0, 0x0, 0x0, (byte) 0x49, (byte) 0x45, (byte) 0x4e, (byte) 0x44, (byte) 0xae, (byte) 0x42, (byte) 0x60, (byte) 0x82};
		
	    static final ByteArrayResource blankPng =new ByteArrayResource(blankPngBytes, "empty.png");
	    
		
		public Resource loadResource(String fileName) throws MalformedURLException{
			//log.info("LoadResource :>>>>>>>>>>> Storage Path : {}, FileName : {} ",storagePath, fileName);
				System.out.println("loadresource string argument method in preview controller ");
			return loadResource(new File(homePath,fileName));

		}

	public Resource loadResource(File file) throws MalformedURLException{
		//log.info("LoadResource :>>>>>>>>>>> Storage Path : {}, File Name : {} ", storagePath, file.getName());
		System.out.printf("storagePath: %s, fileName: %s\n", homePath, file.getName());
		//log.info("file : {} >>>>>>> File URI:{}", file.getAbsolutePath(), file.toURI() );
		System.out.println(file.toURI());
		Resource resource = new UrlResource(file.toURI());
		
		if (!resource.exists() || !resource.isReadable()) {
			//log.info("Resource is not existing ");
		    return blankPng;
	    }
		//log.info("Resource existing");
		return resource;
	}

	public String getFileContentType(String fileName) {
	    String fileType = "Undetermined";
	    final File file = new File(fileName);
	    try
	    {
	        fileType = Files.probeContentType(file.toPath());
	    }
	    catch (IOException ioException)
	    {
	        System.out.println(
	                "ERROR: Unable to determine file type for " + fileName
	                        + " due to exception " + ioException);
	    }
	    return fileType;
	}
}
