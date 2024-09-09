package com.example.test_flutter_01_be.repository;

import com.example.test_flutter_01_be.entity.Place;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlaceRep extends JpaRepository<Place, Integer> {
}
