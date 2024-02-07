package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReadMemberAllDTO {
	private int memberIdx;
	private String memberName;
	private String email;
	private String country;
	private String friendState;
	private String flag;
}
