package com.ssafy.ssap.domain.studyroom;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class ParticipantsRoleNs {

    @Id
    @Column(length = 10)
    private String name;
}
