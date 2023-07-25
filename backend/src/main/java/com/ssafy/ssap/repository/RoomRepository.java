package com.ssafy.ssap.repository;

import com.ssafy.ssap.domain.studyroom.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {
}