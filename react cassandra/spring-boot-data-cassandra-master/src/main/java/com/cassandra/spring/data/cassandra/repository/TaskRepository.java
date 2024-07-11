package com.cassandra.spring.data.cassandra.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.cassandra.repository.AllowFiltering;
import org.springframework.data.cassandra.repository.CassandraRepository;

import com.cassandra.spring.data.cassandra.model.Task;

public interface TaskRepository extends CassandraRepository<Task, UUID> {
  @AllowFiltering
  List<Task> findByPublished(boolean published);
  
  List<Task> findByTitleContaining(String title);
}
