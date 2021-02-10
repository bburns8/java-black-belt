package com.blakeburns.javabeltexam.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.blakeburns.javabeltexam.models.Show;
import com.blakeburns.javabeltexam.repositories.ShowRepository;

@Service
public class ShowService {
	private final ShowRepository courseRepo;
	
	public ShowService(ShowRepository courseRepo) {
		this.courseRepo = courseRepo;
	}
	
	//find all
	public List<Show> findAllCourses(){
		return courseRepo.findAll();
	}
	
	//find by id
	
	public Show findCourseById(Long id) {
		Optional<Show> myCourse = courseRepo.findById(id);
		if(myCourse.isPresent()) {
			return myCourse.get();
		}else {
			return null;
		}
	}
	
	//create course
	public Show createCourse(Show myCourse) {
		return courseRepo.save(myCourse);
	}
	//update course
	public void updateCourse(Show myCourse) {
		courseRepo.save(myCourse);
	}
	//delete course
	public void deleteCourse(Show show) {
		courseRepo.delete(show);
	}

}