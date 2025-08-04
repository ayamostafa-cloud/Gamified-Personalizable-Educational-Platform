
create database projectt ;
CREATE TABLE Learner 
(
    LearnerID INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    birth_date datetime NOT NULL,
    country VARCHAR(50),
    cultural_background VARCHAR(50), 
    Emial   VARCHAR(50)

);

CREATE TABLE Skills (
    LearnerID INT,
    skill VARCHAR(50),
    PRIMARY KEY (LearnerID, skill),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE LearningPreference (
    LearnerID INT PRIMARY KEY,
    preference VARCHAR(50),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE PersonalizationProfiles (
    LearnerID INT,
    ProfileID INT,
    Preferred_content_type VARCHAR(50),
    emotional_state VARCHAR(50),
    personality_type VARCHAR(50),
    PRIMARY KEY (LearnerID, ProfileID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE HealthCondition (
    LearnerID INT,
    ProfileID INT,
    condition VARCHAR(100),
    PRIMARY KEY (LearnerID, ProfileID, condition),
    FOREIGN KEY (LearnerID, ProfileID) REFERENCES PersonalizationProfiles(LearnerID, ProfileID)
);
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100),
    learning_objective VARCHAR(255),
    credit_points INT,
    difficulty_level VARCHAR(50),
    pre_requisites VARCHAR(255),
    description TEXT   
);
CREATE TABLE Modules (
    ModuleID INT ,
    CourseID INT,
    Title VARCHAR(100),
    difficulty VARCHAR(50),
    contentURL TEXT,
    PRIMARY KEY(  ModuleID  ,CourseID) ,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Target_traits (
    ModuleID INT,
    CourseID INT,
    Trait VARCHAR(50),
    PRIMARY KEY (ModuleID, CourseID, Trait),
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);
CREATE TABLE ModuleContent (
    ModuleID INT,
    CourseID INT,
    content_type VARCHAR(50),
    PRIMARY KEY (ModuleID, CourseID, content_type),
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);
CREATE TABLE ContentLibrary (
    ID INT PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    Title VARCHAR(100),
    description TEXT,
    metadata TEXT,
    type VARCHAR(50),
    content_URL TEXT,
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);
CREATE TABLE Assessments (
    ID INT PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    type VARCHAR(50),
    total_marks INT,
    passing_marks INT,
    criteria TEXT,
    weightage DECIMAL(5, 2),
    description TEXT,
    title VARCHAR(100),
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);
CREATE TABLE Learning_activities (
    ActivityID INT PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    activity_type VARCHAR(50),
    instruction_details TEXT,
    Max_points INT,
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);
CREATE TABLE Interaction_log (
    LogID INT PRIMARY KEY,
    activity_ID INT,
    LearnerID INT,
    Duration DECIMAL(5,2),
    Timestamp DATETIME,
    action_type VARCHAR(50),

    FOREIGN KEY (activity_ID) REFERENCES Learning_activities(ActivityID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);


CREATE TABLE Emotional_feedback (
    FeedbackID INT IDENTITY(1,1)  PRIMARY KEY,
    LearnerID INT,
    timestamp DATETIME NOT NULL,
    emotional_state VARCHAR(50),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE Learning_path (
    PathID INT PRIMARY KEY,
    LearnerID INT,
    ProfileID INT,
    completion_status VARCHAR(50),
    custom_content TEXT,
    adaptive_rules TEXT,
    FOREIGN KEY (LearnerID, ProfileID) REFERENCES PersonalizationProfiles(LearnerID, ProfileID)
);
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    name VARCHAR(100),
    latest_qualification VARCHAR(50),
    expertise_area VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE Pathreview (
    InstructorID INT,
    PathID INT,
    feedback TEXT,
    PRIMARY KEY (InstructorID, PathID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    FOREIGN KEY (PathID) REFERENCES Learning_path(PathID)
);
CREATE TABLE Emotionalfeedback_review (
    FeedbackID INT,
    InstructorID INT,
    feedback TEXT,
    PRIMARY KEY (FeedbackID, InstructorID),
    FOREIGN KEY (FeedbackID) REFERENCES Emotional_feedback(FeedbackID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);
CREATE TABLE Course_enrollment (
    EnrollmentID INT PRIMARY KEY,
    CourseID INT,
    LearnerID INT,
    completion_date datetime NOT NULL,
    enrollment_date datetime NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE Teaches (
    InstructorID INT,
    CourseID INT,
    PRIMARY KEY (InstructorID, CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Leaderboard (
    BoardID INT PRIMARY KEY,
    season VARCHAR(50)
);
CREATE TABLE Ranking (
    BoardID INT,
    LearnerID INT,
    CourseID INT,
    rank INT,
    total_points INT,
    PRIMARY KEY (BoardID, LearnerID),
    FOREIGN KEY (BoardID) REFERENCES Leaderboard(BoardID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
CREATE TABLE Learning_goal (
    ID INT PRIMARY KEY,
    status VARCHAR(50),
    deadline datetime NOT NULL,
    description TEXT
);
CREATE TABLE LearnersGoals (
    GoalID INT,
    LearnerID INT,
    PRIMARY KEY (GoalID, LearnerID),  
    FOREIGN KEY (GoalID) REFERENCES Learning_goal(ID),  
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID) 
);

CREATE TABLE Survey (
    ID INT PRIMARY KEY,
    Title VARCHAR(100)
);
CREATE TABLE SurveyQuestions (
    SurveyID INT,
    Question VARCHAR(255),
    PRIMARY KEY (SurveyID, Question),
    FOREIGN KEY (SurveyID) REFERENCES Survey(ID)
);
CREATE TABLE FilledSurvey (
    SurveyID INT,
    Question VARCHAR(255),
    LearnerID INT,
    Answer TEXT,
    PRIMARY KEY (SurveyID, Question, LearnerID),
    FOREIGN KEY (SurveyID, Question) REFERENCES SurveyQuestions(SurveyID, Question),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE Notification (
    ID INT IDENTITY(1,1)   PRIMARY KEY,
    timestamp DATETIME Not Null,
    message TEXT,
    urgency_level VARCHAR(50)
);
CREATE TABLE ReceivedNotification (
    NotificationID  INT ,
    LearnerID INT,
    PRIMARY KEY (NotificationID, LearnerID),
    FOREIGN KEY (NotificationID) REFERENCES Notification(ID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE Badge (
    BadgeID INT PRIMARY KEY,
    title VARCHAR(50),
    description TEXT,
    criteria TEXT,
    points INT
);
CREATE TABLE SkillProgression (
    ID INT PRIMARY KEY,
    proficiency_level VARCHAR(50),
    LearnerID INT,
    skill_name VARCHAR(50),
    timestamp DATETIME Not Null,
    FOREIGN KEY (LearnerID, skill_name) REFERENCES Skills(LearnerID, skill)
);
CREATE TABLE Achievement (
    AchievementID INT IDENTITY(1,1) PRIMARY KEY,
    LearnerID INT,
    BadgeID INT,
    description TEXT,
    date_earned DATETIME Not Null,
    type VARCHAR(50),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (BadgeID) REFERENCES Badge(BadgeID)
);
CREATE TABLE Reward (
    RewardID INT PRIMARY KEY,
    value DECIMAL(10,2),
    description TEXT,
    type VARCHAR(50)
);

CREATE TABLE Quest (
    QuestID INT IDENTITY (1,1) PRIMARY KEY,
    difficulty_level VARCHAR(50),
    criteria VARCHAR(50),
    description TEXT,
    title VARCHAR(100)
);
CREATE TABLE Skill_Mastery (
    QuestID INT,
    skill VARCHAR(50),
    PRIMARY KEY (QuestID, skill),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID)
);
CREATE TABLE Collaborative (
    QuestID INT PRIMARY KEY,
    deadline datetime Not NULL,
    max_num_participants INT,
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID)
);
CREATE TABLE Discussion_forum (
    forumID INT  IDENTITY(1,1) PRIMARY KEY,
    ModuleID INT,
    CourseID INT,
    title VARCHAR(100),
    last_active DATETIME NOT NULL,
    timestamp DATETIME NOT NULL,
    description TEXT,
    FOREIGN KEY (ModuleID, CourseID) REFERENCES Modules(ModuleID, CourseID)
);

CREATE TABLE LearnerDiscussion (
    ForumID INT,
    LearnerID INT,
    Post Varchar(50),
    time DATETIME NOT NULL,
    PRIMARY KEY (ForumID, LearnerID, post),
    FOREIGN KEY (ForumID) REFERENCES
    Discussion_forum(forumID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
CREATE TABLE LearnerAssessment (
    LearnerID INT,
    ID INT,
    score DECIMAL(5, 2),
    PRIMARY KEY (LearnerID, ID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (ID) REFERENCES Assessments(ID)
);
CREATE TABLE QuestReward (
    RewardID INT,
    QuestID INT,
    LearnerID INT,
    Time_earned DATETIME NOT NULL,
    PRIMARY KEY (RewardID, QuestID, LearnerID),
    FOREIGN KEY (RewardID) REFERENCES Reward(RewardID),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID)
);
ALTER TABLE Learner
ADD Email VARCHAR(255);
