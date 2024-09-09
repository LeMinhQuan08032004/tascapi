package com.example.test_flutter_01_be.service;

import com.example.test_flutter_01_be.entity.Place;
import com.example.test_flutter_01_be.repository.PlaceRep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@Service
public class PlaceService {
    @Autowired
    private PlaceRep placeRep;
    private final Path root = Paths.get("uploads");

    public Place savePlace(Place place, MultipartFile file) throws Exception {
        if (!Files.exists(root)) {
            Files.createDirectories(root);
        }

        String filename = file.getOriginalFilename();
        Files.copy(file.getInputStream(), this.root.resolve(filename));

        place.setImageUrl(filename);
        return placeRep.save(place);
    }
    public List<Place> getAllPlace() {
        return placeRep.findAll();
    }

    public Optional<Place> getPlaceById(int id) {
        return placeRep.findById(id);
    }

    // Update Place
    public Place updatePlace(int id, String name, String description,  MultipartFile file) throws Exception {
        Optional<Place> optionalPlace = placeRep.findById(id);
        if (optionalPlace.isPresent()) {
            Place place = optionalPlace.get();
            place.setName(name);
            place.setDescription(description);

            if (file != null && !file.isEmpty()) {
                if (!Files.exists(root)) {
                    Files.createDirectories(root);
                }

                String filename = file.getOriginalFilename();
                Files.copy(file.getInputStream(), this.root.resolve(filename));

                place.setImageUrl(filename);
            }

            return placeRep.save(place);
        } else {
            throw new Exception("Place not found");
        }
    }

    // Xóa Place theo ID
    public void deletePlace(int id) throws Exception {
        if (placeRep.existsById(id)) {
            placeRep.deleteById(id);
        } else {
            throw new Exception("Place not found");
        }
    }
}
