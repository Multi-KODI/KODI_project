package dto;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WritePostDTO {
   private String title;
   private String content;
   private String regdate;
   private String address;
   private String category;
   private double grade;
   private List<String> postTags;
   private List<String> postImages;
}

