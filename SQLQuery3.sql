use projectt



INSERT INTO Learner (LearnerID, first_name, last_name, gender, birth_date, country, cultural_background, email)
VALUES 
(1, 'John', 'Doe', 'M', '2000-05-15', 'USA', 'Western', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'F', '1995-09-20', 'UK', 'European', 'jane.smith@example.com'),
(3, 'Ali', 'Khan', 'M', '1998-03-12', 'Pakistan', 'Asian', 'ali.khan@example.com'),
(4, 'Maria', 'Garcia', 'F', '1993-07-22', 'Spain', 'Hispanic', 'maria.garcia@example.com'),
(5, 'Chen', 'Wang', 'M', '1990-11-10', 'China', 'Asian', 'chen.wang@example.com');

INSERT INTO Skills (LearnerID, skill)
VALUES 
(1, 'Python'),
(2, 'Java'),
(3, 'Machine Learning'),
(4, 'C++'),
(5, 'Web Development');

INSERT INTO LearningPreference (LearnerID, preference)
VALUES 
(1, 'Visual'),
(2, 'Auditory'),
(3, 'Kinesthetic'),
(4, 'Reading/Writing'),
(5, 'Visual');

INSERT INTO PersonalizationProfiles (LearnerID, ProfileID, Preferred_content_type, emotional_state, personality_type)
VALUES 
(1, 101, 'Videos', 'Happy', 'Extrovert'),
(2, 102, 'Articles', 'Calm', 'Introvert'),
(3, 103, 'Interactive', 'Excited', 'Ambivert'),
(4, 104, 'Podcasts', 'Focused', 'Analytical'),
(5, 105, 'Games', 'Curious', 'Creative');

INSERT INTO HealthCondition (LearnerID, ProfileID, condition)
VALUES 
(1, 101, 'Colorblind'),
(2, 102, 'Hearing Impairment'),
(3, 103, 'Dyslexia'),
(4, 104, 'None'),
(5, 105, 'ADHD');


INSERT INTO Course (CourseID, Title, learning_objective, credit_points, difficulty_level, pre_requisites, description)
VALUES 
(1, 'Data Science 101', 'Introduction to Data Science', 3, 'Beginner', 'None', 'Learn the basics of data science.'),
(2, 'Web Development', 'Build websites', 3, 'Intermediate', 'HTML', 'Comprehensive web development course.'),
(3, 'Machine Learning', 'Learn ML algorithms', 4, 'Advanced', 'Python', 'An advanced course on machine learning.'),
(4, 'Algorithms', 'Design and analyze algorithms', 4, 'Intermediate', 'Programming', 'Detailed study of algorithms.'),
(5, 'Databases', 'Learn database design', 3, 'Beginner', 'None', 'Database management and SQL.'),
(6, 'Introduction to Programming', 'Learn the basics of programming in Python', 3, 'Beginner', 'None', 'This course covers the fundamentals of programming using Python, including variables, loops, functions, and basic problem-solving techniques.');

INSERT INTO Modules (ModuleID, CourseID, Title, difficulty, contentURL)
VALUES 
(1, 1, 'Introduction to Data', 'Beginner', 'http://example.com/module1'),
(2, 2, 'Data Cleaning', 'Intermediate', 'http://example.com/module2'),
(3, 3, 'HTML Basics', 'Beginner', 'http://example.com/module3'),
(4, 4, 'Supervised Learning', 'Advanced', 'http://example.com/module4'),
(5, 5, 'Sorting Algorithms', 'Intermediate', 'http://example.com/module5'),
(6,6, 'Introduction to Programming', 'Beginner', 'http://example.com/module1');


INSERT INTO Target_traits (ModuleID, CourseID, Trait)
VALUES 
(1, 1, 'Analytical Thinking'),
(2, 2, 'Attention to Detail'),
(3, 3, 'Creativity'),
(4, 4, 'Problem-Solving'),
(5, 5, 'Critical Thinking');

INSERT INTO ModuleContent (ModuleID, CourseID, content_type)
VALUES 
(1, 1, 'Video'),
(2, 2, 'Text'),
(3, 3, 'Interactive'),
(4, 4, 'Game'),
(5, 5, 'Podcast');

INSERT INTO ContentLibrary (ID, ModuleID, CourseID, Title, description, metadata, type, content_URL)
VALUES 
(1, 1, 1, 'Introduction Video', 'Overview of the course', '{}', 'Video', 'http://example.com/content1'),
(2, 2, 2, 'Data Cleaning Tutorial', 'Data cleaning techniques', '{}', 'Tutorial', 'http://example.com/content2'),
(3, 3, 3, 'HTML Basics Guide', 'Introduction to HTML', '{}', 'Guide', 'http://example.com/content3'),
(4, 4, 4, 'Supervised Learning Video', 'ML Supervised Learning', '{}', 'Video', 'http://example.com/content4'),
(5, 5, 5, 'Sorting Algorithms', 'Learn sorting techniques', '{}', 'Text', 'http://example.com/content5');


INSERT INTO Assessments (ID, ModuleID, CourseID, type, total_marks, passing_marks, criteria, weightage, description, title)
VALUES 
(1, 1, 1, 'Quiz', 100, 50, 'MCQs', 20.00, 'Introduction to data quiz', 'Data Basics Quiz'),
(2, 2, 2, 'Assignment', 100, 60, 'Practical implementation', 30.00, 'Data cleaning assignment', 'Data Cleaning Task'),
(3, 3, 3, 'Project', 100, 70, 'Build a web page', 40.00, 'Web development project', 'HTML Project'),
(4, 4, 4, 'Exam', 100, 50, 'Theory-based', 50.00, 'Machine learning fundamentals', 'ML Exam'),
(5, 5, 5, 'Lab', 100, 75, 'Practical coding', 25.00, 'Algorithm implementation', 'Sorting Lab');


INSERT INTO Interaction_log (LogID, activity_ID, LearnerID, Duration, Timestamp, action_type)
VALUES 
(1, 1, 1, 2.5, '2024-11-25 10:00:00', 'Video Watched'),
(2, 2, 2, 3.0, '2024-11-25 11:00:00', 'Quiz Attempted'),
(3, 3, 3, 1.5, '2024-11-25 12:00:00', 'Assignment Submitted'),
(4, 4, 4, 2.0, '2024-11-25 13:00:00', 'Content Reviewed'),
(5, 5, 5, 2.5, '2024-11-25 14:00:00', 'Module Completed');

INSERT INTO Learning_activities (ActivityID, ModuleID, CourseID, activity_type, instruction_details, Max_points)
VALUES 
(1, 1, 1, 'Video', 'Watch the introduction video', 10),
(2, 2, 2, 'Quiz', 'Answer the MCQs', 20),
(3, 3, 3, 'Assignment', 'Submit a webpage', 30),
(4, 4, 4, 'Exam', 'Attempt the theory exam', 50),
(5, 5, 5, 'Lab', 'Write sorting algorithms', 25);

INSERT INTO Emotional_feedback ( LearnerID, timestamp, emotional_state)
VALUES 
( 1, '2024-11-24 10:00:00', 'Happy'),
( 2, '2024-11-24 11:00:00', 'Calm'),
( 3, '2024-11-24 12:00:00', 'Focused'),
( 4, '2024-11-24 13:00:00', 'Excited'),
( 5, '2024-11-24 14:00:00', 'Curious');

INSERT INTO Learning_path (PathID, LearnerID, ProfileID, completion_status, custom_content, adaptive_rules)
VALUES 
(1, 1, 101, 'Completed', 'Video tutorials', 'Adapt to visual content'),
(2, 2, 102, 'In Progress', 'Articles', 'Adapt to reading content'),
(3, 3, 103, 'In Progress', 'Interactive games', 'Adjust based on performance'),
(4, 4, 104, 'Not Started', 'Podcasts', 'Adapt to auditory learners'),
(5, 5, 105, 'Completed', 'Quizzes', 'Adapt to logical reasoning');

INSERT INTO Instructor (InstructorID, name, latest_qualification, expertise_area, email)
VALUES 
(1, 'Dr. Sarah Johnson', 'PhD', 'Data Science', 'sarah.johnson@example.com'),
(2, 'Mr. Alan Brown', 'Masters', 'Web Development', 'alan.brown@example.com'),
(3, 'Dr. Emily Davis', 'PhD', 'Machine Learning', 'emily.davis@example.com'),
(4, 'Prof. David Wilson', 'PhD', 'Algorithms', 'david.wilson@example.com'),
(5, 'Ms. Rachel Green', 'Masters', 'Databases', 'rachel.green@example.com');

INSERT INTO Pathreview (InstructorID, PathID, feedback)
VALUES 
(1, 1, 'Excellent progress on visual learning.'),
(2, 2, 'Good understanding of content but needs improvement.'),
(3, 3, 'Great engagement with interactive modules.'),
(4, 4, 'Student needs to start the assigned content.'),
(5, 5, 'Completion shows strong logical skills.'); 


INSERT INTO Emotionalfeedback_review (FeedbackID, InstructorID, feedback)
VALUES 
(1, 1, 'Positive feedback; learner is happy.'),
(2, 2, 'Learner is calm and progressing well.'),
(3, 3, 'Focused learner; no issues noted.'),
(4, 4, 'Excited about learning; keep engaging content.'),
(5, 5, 'Curious learner showing great potential.');

INSERT INTO Course_enrollment (EnrollmentID, CourseID, LearnerID, completion_date, enrollment_date, status)
VALUES 
(1, 1, 1, '2024-11-30', '2024-11-01', 'Completed'),
(2, 2, 2, '2024-12-15', '2024-11-05', 'In Progress'),
(3, 3, 3, '2024-12-16', '2024-11-10', 'Not Started'),
(4, 4, 4, '2024-12-20', '2024-11-15', 'Completed'),
(5, 5, 5, '2024-12-17', '2024-11-20', 'In Progress');

INSERT INTO Teaches (InstructorID, CourseID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Leaderboard (BoardID, season)
VALUES 
(1, 'Spring 2024'),
(2, 'Summer 2024'),
(3, 'Fall 2024'),
(4, 'Winter 2024'),
(5, 'Spring 2025');

INSERT INTO Ranking (BoardID, LearnerID, CourseID, rank, total_points)
VALUES 
(1, 1, 1, 1, 95),
(2, 2, 2, 2, 85),
(3, 3, 3, 3, 75),
(4, 4, 4, 4, 65),
(5, 5, 5, 5, 55);

INSERT INTO Learning_goal (ID, status, deadline, description)
VALUES 
(1, 'Achieved', '2024-12-01', 'Master basic data concepts.'),
(2, 'In Progress', '2024-12-15', 'Complete web development basics.'),
(3, 'Pending', '2025-01-01', 'Learn advanced machine learning.'),
(4, 'Achieved', '2024-12-20', 'Understand algorithms deeply.'),
(5, 'In Progress', '2024-12-31', 'Improve database skills.');

INSERT INTO LearnersGoals (GoalID, LearnerID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO Survey (ID, Title)
VALUES 
(1, 'Feedback on Course Content'),
(2, 'Learner Engagement Survey'),
(3, 'Course Difficulty Analysis'),
(4, 'Instructor Evaluation'),
(5, 'Future Course Preferences');

INSERT INTO SurveyQuestions (SurveyID, Question)
VALUES 
(1, 'How would you rate the course content?'),
(2, 'Was the content engaging and clear?'),
(3, 'How frequently do you engage with the course material?'),
(4, 'Did you find the course difficulty appropriate?'),
(5, 'How would you rate the instructor’s teaching?');

INSERT INTO FilledSurvey (SurveyID, Question, LearnerID, Answer)
VALUES 
(1, 'How would you rate the course content?', 1, 'Excellent'),
(2, 'Was the content engaging and clear?', 2, 'Very Clear'),
(3, 'How frequently do you engage with the course material?', 3, 'Daily'),
(4, 'Did you find the course difficulty appropriate?', 4, 'Moderate'),
(5, 'How would you rate the instructor’s teaching?', 5, 'Outstanding');

INSERT INTO Notification ( timestamp, message, urgency_level)
VALUES 
( '2024-11-25 08:00:00', 'Your course has a new module available.', 'Medium'),
( '2024-11-25 09:00:00', 'You have an assignment deadline tomorrow.', 'High'),
( '2024-11-25 10:00:00', 'A new leaderboard has been published.', 'Low'),
( '2024-11-25 11:00:00', 'Your course enrollment has been approved.', 'Low'),
( '2024-11-25 12:00:00', 'Your learning goal deadline is approaching.', 'High');

INSERT INTO ReceivedNotification (NotificationID, LearnerID)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Badge (BadgeID, title, description, criteria, points)
VALUES 
(1, 'Data Guru', 'Mastered data concepts', 'Complete all data modules', 100),
(2, 'Web Wizard', 'Excelled in web development', 'Build a website project', 150),
(3, 'Machine Master', 'Top scorer in ML exam', 'Score above 90%', 200),
(4, 'Algorithm Ace', 'Master algorithms', 'Solve advanced problems', 120),
(5, 'DB Dynamo', 'Excel in database projects', 'Complete all database tasks', 110);

INSERT INTO SkillProgression (ID, proficiency_level, LearnerID, skill_name, timestamp)
VALUES 
(1, 'Beginner', 1, 'Python', '2024-11-24 10:00:00'),
(2, 'Intermediate', 2, 'Java', '2024-11-24 11:00:00'),
(3, 'Advanced', 3, 'Machine Learning', '2024-11-24 12:00:00'),
(4, 'Expert', 4, 'C++', '2024-11-24 13:00:00'),
(5, 'Beginner', 5, 'Web Development', '2024-11-24 14:00:00');

INSERT INTO Achievement ( LearnerID, BadgeID, description, date_earned, type)
VALUES
( 1, 1, 'Completed Data Guru Badge', '2024-11-20 14:00:00', 'Badge'),
( 2, 2, 'Completed Web Wizard Badge', '2024-11-21 15:00:00', 'Badge'),
( 3, 3, 'Completed Machine Master Badge', '2024-11-22 16:00:00', 'Badge'),
( 4, 4, 'Completed Algorithm Ace Badge', '2024-11-23 17:00:00', 'Badge'),
( 5, 5, 'Completed DB Dynamo Badge', '2024-11-24 18:00:00', 'Badge');

INSERT INTO Reward (RewardID, value, description, type)
VALUES
(1, 50.00, 'Reward for achieving Data Guru', 'Monetary'),
(2, 100.00, 'Reward for completing Web Wizard', 'Gift Card'),
(3, 75.00, 'Reward for Machine Master', 'Points'),
(4, 200.00, 'Reward for Algorithm Ace', 'Cashback'),
(5, 25.00, 'Reward for DB Dynamo', 'Discount');


INSERT INTO Quest ( difficulty_level, criteria, description, title)
VALUES
('Easy', 'Complete 2 modules', 'Basic Data ', 'Data Explorer'),
( 'Medium', 'Build a web project', 'Intermediate ', 'Web Creator'),
( 'Hard', 'Achieve top ML score', 'Advanced ', 'ML Pro'),
( 'Very Hard', 'Solve 3 algorithm problems', 'Algorithm t', 'Algo Ace'),
( 'Easy', 'Complete 3 database tasks', 'Database ', 'DB Starter');

INSERT INTO Skill_Mastery (QuestID, skill)
VALUES
(1, 'Data Analysis'),
(2, 'Web Development'),
(3, 'Machine Learning'),
(4, 'Algorithms'),
(5, 'Database Management');


INSERT INTO Collaborative (QuestID, deadline, max_num_participants)
VALUES
(1, '2024-12-01 12:00:00', 5),
(2, '2024-12-05 14:00:00', 10),
(3, '2024-12-10 16:00:00', 8),
(4, '2024-12-15 18:00:00', 6),
(5, '2024-12-20 20:00:00', 4);

INSERT INTO Discussion_forum ( ModuleID, CourseID, title, last_active, timestamp, description)
VALUES
( 1, 1, 'Data Module Forum', '2024-11-20 10:00:00', '2024-11-19 09:00:00', 'Discuss data concepts.'),
( 2, 2, 'Web Dev Forum', '2024-11-21 11:00:00', '2024-11-20 10:00:00', 'Share web development ideas.'),
( 3, 3, 'ML Forum', '2024-11-22 12:00:00', '2024-11-21 11:00:00', 'Discuss machine learning techniques.'),
( 4, 4, 'Algorithm Forum', '2024-11-23 13:00:00', '2024-11-22 12:00:00', 'Collaborate on algorithm problems.'),
( 5, 5, 'DB Forum', '2024-11-24 14:00:00', '2024-11-23 13:00:00', 'Exchange database management tips.');


INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, time) 
VALUES
(1, 1, 'informative!', '2024-11-20 11:00:00'),
(2, 2, 'Can ', '2024-11-21 12:00:00'),
(3, 3, 'What', '2024-11-22 13:00:00'),
(4, 4, 'How ', '2024-11-23 14:00:00'),
(5, 5, 'WhatS', '2024-11-24 15:00:00');

INSERT INTO LearnerAssessment (LearnerID, ID, score)
VALUES
(1, 1, 90.00),
(2, 2, 85.00),
(3, 3, 80.00),
(4, 4, 95.00),
(5, 5, 75.00);

INSERT INTO QuestReward (RewardID, QuestID, LearnerID, Time_earned)
VALUES
(1, 1, 1, '2024-11-25 12:00:00'),
(2, 2, 2, '2024-11-26 13:00:00'),
(3, 3, 3, '2024-11-27 14:00:00'),
(4, 4, 4, '2024-11-28 15:00:00'),
(5, 5, 5, '2024-11-29 16:00:00');