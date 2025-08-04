use projectt

GO
CREATE PROCEDURE ViewInfo
    @LearnerID int
AS
    SELECT *
    FROM Learner
    WHERE LearnerID = @LearnerID;

 EXEC ViewInfo @LearnerID = 1; 



GO
CREATE PROCEDURE LearnerInfo
@LearnerID int 
AS

    SELECT *
    FROM PersonalizationProfiles
    WHERE LearnerID = @LearnerID;
    EXEC LearnerInfo @LearnerID = 1;

 
GO
CREATE PROCEDURE EmotionalState
    @LearnerID INT,
    @emotional_state VARCHAR(50) OUTPUT
AS
BEGIN
    
    SELECT TOP 1 
        @emotional_state = emotional_state
    FROM 
        Emotional_feedback
    WHERE 
        LearnerID = @LearnerID
    ORDER BY 
        Timestamp DESC; 

   
    IF @emotional_state IS NULL
    BEGIN
        SET @emotional_state = 'No emotional state found.';
    END
END;
DECLARE @emotional_state VARCHAR(50);
EXEC EmotionalState @LearnerID = 1, @emotional_state = @emotional_state OUTPUT;
SELECT @emotional_state AS LatestEmotionalState;






GO
CREATE PROCEDURE LogDetails
@LearnerID int
AS
    SELECT *
    FROM Interaction_log
    WHERE LearnerID = @LearnerID
    ORDER BY Timestamp DESC;
EXEC LogDetails @LearnerID = 1;




GO
CREATE PROCEDURE InstructorReview
@InstructorID int
AS

    SELECT ef.*, er.feedback AS InstructorFeedback
    FROM Emotional_feedback ef
    INNER JOIN Emotionalfeedback_review er ON ef.FeedbackID = er.FeedbackID
    WHERE er.InstructorID = @InstructorID;

    EXEC InstructorReview @InstructorID = 1;  


 DROP PROCEDURE CourseRemove ;
GO
CREATE PROCEDURE CourseRemove ---------------
    @CourseID INT
AS
BEGIN
    
    DECLARE @IsBeingTaught INT;
    SELECT @IsBeingTaught = COUNT(*)
    FROM Teaches
    WHERE CourseID = @CourseID;
    IF @IsBeingTaught = 0
    BEGIN
        DELETE FROM Course
        WHERE CourseID = @CourseID;
    END
END;

    EXEC CourseRemove @CourseID = 5;




GO
CREATE PROCEDURE Highestgrade
AS

    SELECT CourseID, MAX(total_marks) AS MaxMarks
    FROM Assessments
    GROUP BY CourseID;
    EXEC Highestgrade;



GO
CREATE PROCEDURE InstructorCount 
AS

    SELECT CourseID
    FROM Teaches
    GROUP BY CourseID
    HAVING COUNT(InstructorID) > 1;
    EXEC InstructorCount;



GO 
CREATE PROCEDURE ViewNot
@LearnerID int 
AS

    SELECT n.*
    FROM Notification n
    INNER JOIN ReceivedNotification rn
    ON n.ID = rn.NotificationID
    WHERE rn.LearnerID = @LearnerID;
    EXEC ViewNot @LearnerID = 1;


DROP PROCEDURE CreateDiscussion;
GO
CREATE PROCEDURE CreateDiscussion  
    @ModuleID INT, 
    @CourseID INT, 
    @Title VARCHAR(50), 
    @Description VARCHAR(50)
   

AS

    INSERT INTO Discussion_forum (  ModuleID, CourseID, title, description, last_active, timestamp)
    VALUES (@ModuleID, @CourseID, @Title, @Description, GETDATE(), GETDATE());
    
   print 'Discussion forum created successfully.';

   EXEC CreateDiscussion 
  
    @ModuleID = 6, 
    @CourseID = 6, 
    @Title = 'Module 1 Q&A', 
    @Description = 'Discussion forum for Module 1 questions.';

    drop  PROCEDURE RemoveBadge ;
GO
CREATE PROCEDURE RemoveBadge  
@BadgeID int
AS
    DELETE FROM Achievement
    WHERE BadgeID = @BadgeID;
    
    print 'Badge removed successfully.' 
EXEC RemoveBadge @BadgeID = 1;

GO 
CREATE PROCEDURE CriteriaDelete  
@Criteria VARCHAR(50)
AS
    DELETE FROM Quest
    WHERE criteria = @Criteria;
    EXEC CriteriaDelete @Criteria = 'Basic Data '; 


GO 
CREATE PROCEDURE NotificationUpdate
@LearnerID int, 
@NotificationID int,
@ReadStatus bit 
AS

    BEGIN
        DELETE FROM ReceivedNotification
        WHERE NotificationID = @NotificationID AND LearnerID = @LearnerID;
    END;

EXEC NotificationUpdate @LearnerID = 3, @NotificationID = 4, @ReadStatus = 1;


   drop procedure EmotionalTrendAnalysis;
   GO
CREATE PROCEDURE EmotionalTrendAnalysis
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod DATETIME  
AS
BEGIN
    SELECT 
        M.ModuleID,
        M.CourseID,
        ef.emotional_state,
        ef.timestamp
    FROM   
        Modules M
    INNER JOIN 
        Course_enrollment ce ON M.CourseID = ce.CourseID 
    INNER JOIN 
        Emotional_feedback ef ON ce.LearnerID = ef.LearnerID
    WHERE 
        M.CourseID = @CourseID
        AND M.ModuleID = @ModuleID
        AND ef.timestamp BETWEEN @TimePeriod AND GETDATE() 
    ORDER BY 
        ef.timestamp;
END;
EXEC EmotionalTrendAnalysis @CourseID = 2, @ModuleID = 2, @TimePeriod = '2024-11-01 00:00:00';
 


GO
 CREATE PROCEDURE ProfileUpdate
    @learnerID INT, 
    @ProfileID INT, 
    @PreferedContentType VARCHAR(50),
    @emotional_state VARCHAR(50), 
    @PersonalityType VARCHAR(50)
AS

    UPDATE PersonalizationProfiles
    SET 
        Preferred_content_type = @PreferedContentType,
        emotional_state = @emotional_state,
        personality_type = @PersonalityType
    WHERE 
        LearnerID = @learnerID AND 
        ProfileID = @ProfileID;

EXEC ProfileUpdate @learnerID = 1, @ProfileID = 10, @PreferedContentType = 'Video', @emotional_state = 'Happy', @PersonalityType = 'Extrovert';

GO
 CREATE PROCEDURE TotalPoints
 @LearnerID int,
 @RewardType varchar(50)
 As 
    SELECT sum(value ) as TotalPoints 
     from Reward R inner join QuestReward Qr  on R.RewardID = QR.RewardID
    WHERE QR.LearnerID = @LearnerID
      AND R.type = @RewardType;
EXEC TotalPoints @LearnerID = 2, @RewardType = 'Gift Card';



 
Go
CREATE PROCEDURE EnrolledCourses  
    @LearnerID INT
AS
    SELECT C.CourseID, C.Title, Course_enrollment.enrollment_date, Course_enrollment.status
    FROM Course C
    INNER JOIN Course_enrollment 
    ON C.CourseID = Course_enrollment.CourseID
    WHERE Course_enrollment .LearnerID = @LearnerID AND Course_enrollment .status = 'Enrolled';

    EXEC EnrolledCourses @LearnerID = 4 ;


GO
CREATE PROCEDURE Prerequisites
    @LearnerID INT,
    @CourseID INT
AS
BEGIN
   
    DECLARE @Prerequisites VARCHAR(255);

    SELECT @Prerequisites = PrerequisiteCourseID
    FROM Course
    WHERE CourseID = @CourseID;

    
    IF @Prerequisites IS NULL OR @Prerequisites = 'None'
    BEGIN
        PRINT 'All prerequisites are completed.';
        RETURN;
    END
    IF EXISTS (
        SELECT 1
        FROM STRING_SPLIT(@Prerequisites, ',') AS Prerequisite
        WHERE CAST(Prerequisite.value AS INT) NOT IN (
            SELECT CourseID
            FROM Course_enrollment
            WHERE LearnerID = @LearnerID AND status = 'Completed'
        )
    )
    BEGIN
        PRINT 'Some prerequisites are not completed.';
    END
    ELSE
    BEGIN
        PRINT 'All prerequisites are completed.';
    END
END;

  EXEC Prerequisites @LearnerID = 1, @CourseID = 1;


GO
CREATE PROCEDURE ModuleTraits
    @TargetTrait VARCHAR(50),
    @CourseID INT
AS

    SELECT ModuleID, Title
    FROM Modules
    WHERE CourseID = @CourseID AND ModuleID IN (
          SELECT ModuleID
          FROM Target_traits
          WHERE Trait = @TargetTrait
      );
EXEC ModuleTraits @TargetTrait = 'Problem-Solving', @CourseID = 1;

 Go
CREATE PROCEDURE LeaderboardRank
    @LeaderboardID INT
AS

    SELECT LearnerID, rank, total_points
    FROM Ranking
    WHERE BoardID = @LeaderboardID
    ORDER BY rank;
EXEC LeaderboardRank @LeaderboardID = 1;



drop PROCEDURE ViewMyDeviceCharge ; 
GO
CREATE PROCEDURE ViewMyDeviceCharge
    @ActivityID INT,
    @LearnerID INT,
    @Timestamp TIME,  -- Change the type of @Timestamp to TIME
    @EmotionalState VARCHAR(50)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Interaction_log IL
        INNER JOIN Learning_activities LA ON IL.activity_ID = LA.ActivityID
        WHERE IL.activity_ID = @ActivityID AND IL.LearnerID = @LearnerID
    )
    BEGIN
        -- Insert emotional feedback with the updated @Timestamp as TIME
        INSERT INTO Emotional_feedback (LearnerID, Timestamp, emotional_state)
        VALUES (@LearnerID, @Timestamp, @EmotionalState);
    END
END;

EXEC ViewMyDeviceCharge @ActivityID = 1, @LearnerID = 1, @Timestamp = '12:30:00', @EmotionalState = 'Happy';


GO
CREATE PROCEDURE JoinQuest
    @LearnerID INT,
    @QuestID INT
AS
    DECLARE @MaxParticipants INT, @CurrentParticipants INT;

    SELECT @MaxParticipants = max_num_participants
    FROM Collaborative
    WHERE QuestID = @QuestID;

    SELECT @CurrentParticipants = COUNT(*)
    FROM QuestReward
    WHERE QuestID = @QuestID;

    IF @CurrentParticipants < @MaxParticipants
    BEGIN
        INSERT INTO QuestReward (RewardID, QuestID, LearnerID)
        VALUES (NULL, @QuestID, @LearnerID);
        PRINT 'Successfully joined the quest.';
    END
    ELSE
        PRINT 'Quest is full. Cannot join.';
EXEC JoinQuest @LearnerID = 1, @QuestID = 202; 


GO
CREATE PROCEDURE SkillsProficiency
    @LearnerID INT
AS

    SELECT skill_name, proficiency_level, timestamp
    FROM SkillProgression
    WHERE LearnerID = @LearnerID;
EXEC SkillsProficiency @LearnerID = 1;

GO
CREATE PROCEDURE Viewscore
    @LearnerID INT,
    @AssessmentID INT
AS

   
    SELECT Score
    FROM LearnerAssessment
    WHERE LearnerID = @LearnerID AND ID = @AssessmentID;
EXEC Viewscore @LearnerID = 1, @AssessmentID = 1;


GO
CREATE PROCEDURE AssessmentsList
    @CourseID INT,
    @ModuleID INT
AS

    SELECT A.ID AS AssessmentID, A.Title, A.Type, LA.Score
    FROM Assessments A
    INNER JOIN LearnerAssessment LA ON A.ID = LA.ID
    WHERE A.CourseID = @CourseID AND A.ModuleID = @ModuleID;
EXEC AssessmentsList @CourseID = 1, @ModuleID = 1;
  

GO
CREATE PROCEDURE CourseRegister    
    @LearnerID INT,
    @CourseID INT ,
    @EnrollmentID int
AS
BEGIN
    IF NOT EXISTS (
        SELECT  PrerequisiteCourseID
        FROM Course
        WHERE CourseID = @CourseID
          AND (
              ISNUMERIC(pre_requisites) = 1 
              AND  PrerequisiteCourseID NOT IN (
                  SELECT CourseID 
                  FROM Course_enrollment 
                  WHERE LearnerID = @LearnerID AND status = 'Completed'
              )
          )
    )
    BEGIN
        INSERT INTO Course_enrollment ( EnrollmentID ,LearnerID, CourseID, enrollment_date, status ,completion_date)
        VALUES (@EnrollmentID ,@LearnerID, @CourseID, GETDATE(), 'Enrolled' ,'1/2/2020');
        PRINT 'Registration approved.';
    END
    ELSE
    BEGIN
        PRINT 'Registration rejected: prerequisites not completed or invalid prerequisite.';
    END
END;

EXEC CourseRegister  @EnrollmentID =1 ,@LearnerID = 5, @CourseID = 2; 


 GO
CREATE PROCEDURE Post  
    @LearnerID INT,
    @DiscussionID INT,
    @Post VARCHAR(MAX)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Discussion_forum WHERE forumID = @DiscussionID)
    BEGIN
        INSERT INTO LearnerDiscussion (ForumID, LearnerID, Post, Time)
        VALUES (@DiscussionID, @LearnerID, @Post, GETDATE());
    END
    ELSE
    BEGIN
        PRINT 'Error: Discussion ID does not exist.';
    END
END;

   EXEC Post @LearnerID = 1, @DiscussionID = 1, @Post = 'This is my contribution ';

 DROP PROCEDURE AddGoal;
GO
CREATE PROCEDURE AddGoal    
    @LearnerID INT,
    @GoalID INT
AS
    INSERT INTO LearnersGoals (GoalID,LearnerID)
    VALUES (@GoalID, @LearnerID);
   EXEC AddGoal @LearnerID = 6, @GoalID = 6;

GO
CREATE PROCEDURE CurrentPath
    @LearnerID INT
AS

    SELECT PathID, ProfileID, Completion_Status, Custom_Content, Adaptive_Rules
    FROM Learning_Path
    WHERE LearnerID = @LearnerID;
    EXEC CurrentPath @LearnerID = 1;


    DROP PROCEDURE QuestMembers;
GO
CREATE PROCEDURE QuestMembers
    @LearnerID INT
AS
BEGIN
    SELECT 
        Q.QuestID,
        Q.title AS QuestTitle,
        L.LearnerID,
        L.first_name,
        L.last_name,
        C.deadline
    FROM 
        Collaborative C
    JOIN Quest Q ON C.QuestID = Q.QuestID
    JOIN QuestReward CQ ON CQ.QuestID = Q.QuestID 
    JOIN Learner L ON CQ.LearnerID = L.LearnerID
    WHERE 
        C.deadline >= GETDATE()  
        AND CQ.LearnerID = @LearnerID;
END;
DECLARE @LearnerID INT = 1;  
EXEC QuestMembers @LearnerID;


DROP VIEW QuestProgress;

GO
CREATE VIEW QuestProgress 
AS
SELECT  
    Q.QuestID, 
    Q.Title AS QuestTitle,
    Q.Criteria AS QuestCriteria,
    QR.Time_earned AS RewardEarnedDate, 
    B.Title AS BadgeTitle, 
    A.Description AS BadgeDescription
FROM 
    Quest Q
LEFT JOIN 
    QuestReward QR ON Q.QuestID = QR.QuestID
LEFT JOIN 
    Achievement A ON QR.LearnerID = A.LearnerID
LEFT JOIN 
    Badge B ON A.BadgeID = B.BadgeID;

GO
SELECT * FROM QuestProgress;


DROP PROCEDURE GoalReminder ;
GO
CREATE PROCEDURE GoalReminder      
    @LearnerID INT
AS
BEGIN
    SELECT 
        N.ID AS NotificationID,
        N.timestamp AS NotificationDate,
        N.message AS NotificationMessage,
        N.urgency_level AS UrgencyLevel
    FROM 
        Notification N
    INNER JOIN 
        ReceivedNotification RN ON N.ID = RN.NotificationID 
    INNER JOIN 
        LearnersGoals LG ON RN.LearnerID = LG.LearnerID
    WHERE 
        RN.LearnerID = @LearnerID
    ORDER BY 
        N.timestamp DESC;
END;

EXEC GoalReminder @LearnerID = 1;



GO
CREATE PROCEDURE SkillProgressHistory
    @LearnerID INT,
    @Skill VARCHAR(50)
AS
BEGIN
    SELECT SP.timestamp AS DateOfProgression,
           SP.proficiency_level AS ProficiencyLevel,
           SP.skill_name AS Skill,
           SP.LearnerID AS LearnerID
    FROM SkillProgression SP
    WHERE SP.LearnerID = @LearnerID
      AND SP.skill_name = @Skill
    ORDER BY SP.timestamp;
END;
EXEC SkillProgressHistory @LearnerID = 1, @Skill = 'Python';


drop PROCEDURE AssessmentAnalysis;
GO
CREATE PROCEDURE AssessmentAnalysis
    @LearnerID INT,
    @AssessmentID INT
AS
BEGIN
    SELECT 
        A.ID,
        A.Title AS AssessmentTitle,
        A. criteria AS AssessmentCriteria,
        A.total_marks,
        A. passing_marks,
        A.weightage,
        S.Score AS LearnerScore
    FROM Assessments A
    INNER JOIN  LearnerAssessment S ON A.ID = S.ID
    WHERE S.LearnerID = @LearnerID
      AND A.ID = @AssessmentID;
END;
 EXEC AssessmentAnalysis @LearnerID = 1, @AssessmentID = 1;
 



GO
CREATE PROCEDURE LeaderboardFilter
    @LearnerID INT
AS
BEGIN
    SELECT  R.BoardID AS LeaderboardID, R.LearnerID, R.CourseID, R.Rank,
 R.Total_Points AS Points
    FROM  Ranking R
    INNER JOIN Leaderboard L ON R.BoardID = L.BoardID
    WHERE  R.LearnerID = @LearnerID
    ORDER BY  R.Rank DESC; 
END;
EXEC LeaderboardFilter @LearnerID = 1;

go
CREATE PROCEDURE SkillLearners
    @SkillName VARCHAR(50)
AS
BEGIN
    SELECT  S.LearnerID, L.first_name ,L.last_name, S.Skill
    FROM Skills S
    INNER JOIN Learner L ON S.LearnerID = L.LearnerID
    WHERE S.Skill = @SkillName;
END;
EXEC SkillLearners @SkillName = 'Python';

drop PROCEDURE NewActivity;
GO
CREATE PROCEDURE NewActivity   
    @CourseID INT,
    @ModuleID INT,
    @ActivityType VARCHAR(50),
    @InstructionDetails TEXT,
    @MaxPoints INT,
    @ActivityID int
AS
BEGIN
    INSERT INTO Learning_activities ( ActivityID ,CourseID, ModuleID, Activity_Type, Instruction_Details, Max_Points)
    VALUES ( @ActivityID ,@CourseID, @ModuleID, @ActivityType, @InstructionDetails, @MaxPoints);
END;
EXEC NewActivity @ActivityID = 6 ,  @CourseID = 6, @ModuleID = 6, @ActivityType = 'Quiz', @InstructionDetails = 'Complete the quiz on module topics.', @MaxPoints = 50;
  
 
 go
CREATE PROCEDURE NewAchievement
    @LearnerID INT,
    @BadgeID INT,
    @Description NVARCHAR(MAX),
    @DateEarned DATETIME,
    @Type VARCHAR(50) 
   
AS
BEGIN
    INSERT INTO Achievement (   LearnerID, BadgeID, Description, Date_Earned, Type)
    VALUES (  @LearnerID, @BadgeID, @Description, @DateEarned, @Type);
END;
EXEC NewAchievement   @LearnerID = 1, @BadgeID = 5, @Description = 'Outstanding performance in course activities.', @DateEarned = '2024-11-25', @Type = 'Platinum';

GO
CREATE PROCEDURE LearnerBadge       
    @BadgeID INT
AS
BEGIN
    SELECT 
        A.LearnerID,
        L.first_name, 
        L. last_name ,
        B.Title AS BadgeTitle,
        B.Description AS BadgeDescription
    FROM 
        Achievement A
    INNER JOIN Learner L ON A.LearnerID = L.LearnerID
    INNER JOIN Badge B ON A.BadgeID = B.BadgeID
    WHERE 
        A.BadgeID = @BadgeID;
END;

EXEC LearnerBadge @BadgeID = 5;
 

 drop PROCEDURE NewPath ;
GO
CREATE PROCEDURE NewPath
    @LearnerID INT,
    @ProfileID INT,
    @CompletionStatus VARCHAR(50),
    @CustomContent TEXT,
    @AdaptiveRules TEXT ,
    @PathID int 
AS
BEGIN
    INSERT INTO  Learning_path ( PathID ,LearnerID, ProfileID, Completion_Status, Custom_Content, Adaptive_Rules)
    VALUES (@PathID ,@LearnerID, @ProfileID, @CompletionStatus, @CustomContent, @AdaptiveRules);
END;
EXEC NewPath 
    @PathID = 6,
    @LearnerID = 1, 
    @ProfileID = 101, 
    @CompletionStatus = 'In Progress', 
    @CustomContent = 'Custom materials tailored to learner needs', 
    @AdaptiveRules = 'Rule set A';


GO
CREATE PROCEDURE TakenCourses
    @LearnerID INT
AS
BEGIN
    SELECT  CE.CourseID, C.Title AS CourseTitle,
        CE.Completion_Date AS CompletionDate
    FROM Course_enrollment CE
    INNER JOIN Course C ON CE.CourseID = C.CourseID
    WHERE CE.LearnerID = @LearnerID;
END;
EXEC TakenCourses 
    @LearnerID = 2;


    drop PROCEDURE CollaborativeQuest ;
GO
CREATE PROCEDURE CollaborativeQuest -----msh fahma eh el 8alt
    @difficulty_level VARCHAR(50),
    @criteria VARCHAR(50),
    @description VARCHAR(50),
    @title VARCHAR(50),
    @Maxnumparticipants INT,
    @deadline DATETIME
AS
BEGIN
    DECLARE @QuestID INT;
    INSERT INTO Quest (Difficulty_Level, Criteria, Description, Title)
    VALUES (@difficulty_level, @criteria, @description, @title);
    SET @QuestID = SCOPE_IDENTITY();
    INSERT INTO Collaborative (QuestID, Max_Num_Participants, Deadline)
    VALUES (@QuestID, @Maxnumparticipants, @deadline);
END;

   EXEC CollaborativeQuest 
    @difficulty_level = 'Medium', 
    @criteria = 'Teamwork and problem-solving', 
    @description = 'Solve a coding challenge collaboratively', 
    @title = 'Code Hackathon', 
    @Maxnumparticipants = 10, 
    @deadline = '2024-12-31';



GO

  CREATE PROCEDURE DeadlineUpdate
    @QuestID INT,
    @deadline DATETIME
AS
BEGIN
  
    UPDATE  Collaborative
    SET deadline = @deadline
    WHERE QuestID = @QuestID;
   END ;
   EXEC DeadlineUpdate @QuestID = 5, @Deadline = '2024-12-31';

   drop  PROCEDURE GradeUpdate;
 GO
CREATE PROCEDURE GradeUpdate
    @LearnerID INT,
    @AssessmentID INT,
    @Grade DECIMAL(5,2),
    @Points INT 
AS
BEGIN
   
    IF EXISTS (SELECT 1 FROM LearnerAssessment
               WHERE LearnerID = @LearnerID AND ID = @AssessmentID)
    BEGIN
     IF @Grade <= @Points
        UPDATE LearnerAssessment
        SET score  = @Grade
        WHERE LearnerID = @LearnerID AND ID = @AssessmentID;
        
        PRINT 'Grade updated successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Learner or Assessment not found.';
    END
END;
EXEC GradeUpdate @LearnerID = 1, @AssessmentID = 1, @Grade = 85.75,@Points = 100;


    

GO
CREATE PROCEDURE AssessmentNot 
    @timestamp DATETIME,
    @message VARCHAR(MAX),
    @urgencylevel VARCHAR(50),
    @LearnerID INT
AS
BEGIN
    
    INSERT INTO Notification (timestamp, message, urgency_level)
    VALUES (@timestamp, @message, @urgencylevel);
    
   
    DECLARE @NotificationID INT;
    SET @NotificationID = SCOPE_IDENTITY();
    
   
    INSERT INTO ReceivedNotification (NotificationID, LearnerID)
    VALUES (@NotificationID, @LearnerID);
    
    PRINT 'Notification inserted and received notification recorded successfully.';
END;
EXEC AssessmentNot 
    @timestamp = '1/11/2020', 
    @message = 'Assessment due soon', 
    @urgencylevel = 'High', 
    @LearnerID = 1;

    drop PROCEDURE NewGoal ;


 GO
   CREATE PROCEDURE NewGoal
    @GoalID INT,
    @status VARCHAR(MAX),
    @deadline DATETIME,
    @description VARCHAR(MAX)
AS
BEGIN
    
    INSERT INTO Learning_goal (ID, status, deadline, description)
    VALUES (@GoalID, @status, @deadline, @description);
  
    
END;

EXEC NewGoal 
    @GoalID = 7, 
    @status = 'Active', 
    @deadline = '2024-12-31', 
    @description = 'Complete the math course.';


GO
CREATE PROCEDURE LearnersCoutrses
    @CourseID INT,
    @InstructorID INT
AS
BEGIN
    SELECT 
        L.LearnerID,
        L.first_name,
        L.last_name,
        CE.enrollment_date,
        CE.status AS enrollment_status
    FROM 
        Learner L
    JOIN 
        Course_enrollment CE ON L.LearnerID = CE.LearnerID
    JOIN 
        Teaches T ON CE.CourseID = T.CourseID
    WHERE 
        CE.CourseID = @CourseID AND T.InstructorID = @InstructorID;
END;
EXEC LearnersCoutrses 
    @CourseID = 3, 
    @InstructorID = 3;
    

GO
CREATE PROCEDURE LastActive
    @ForumID INT,
    @lastactive DATETIME OUTPUT
AS
BEGIN
   
    SELECT @lastactive = MAX(Time)
    FROM LearnerDiscussion
    WHERE ForumID = @ForumID;
END;
DECLARE @lastactive DATETIME;
EXEC LastActive @ForumID = 101, @lastactive = @lastactive OUTPUT;
SELECT @lastactive AS 'Last Active Time';


GO
CREATE PROCEDURE CommonEmotionalState
    @state VARCHAR(50) OUTPUT
AS
BEGIN

    DECLARE @maxCount INT;

   
    SELECT @maxCount = MAX(stateCount)
    FROM (
        SELECT emotional_state, COUNT(*) AS stateCount
        FROM Emotional_feedback
        GROUP BY emotional_state
    ) AS stateCounts;

    
    SELECT @state = emotional_state
    FROM (
        SELECT emotional_state, COUNT(*) AS stateCount
        FROM Emotional_feedback
        GROUP BY emotional_state
    ) AS stateCounts
    WHERE stateCounts.stateCount = @maxCount;
END;
DECLARE @state VARCHAR(50);
EXEC CommonEmotionalState @state = @state OUTPUT;
SELECT @state AS 'Most Common Emotional State';



 drop PROCEDURE ModuleDifficulty ;
GO
CREATE PROCEDURE ModuleDifficulty
    @courseID INT
AS
BEGIN
   
    SELECT M.ModuleID, M.Title, M.difficulty
    FROM Modules M
    INNER JOIN ModuleContent CM ON M.ModuleID = CM.ModuleID
    WHERE CM.CourseID = @courseID
    ORDER BY M.difficulty;
END;
DECLARE @courseID INT = 4; 
EXEC ModuleDifficulty @courseID;


drop PROCEDURE Profeciencylevel ;
GO
CREATE PROCEDURE Profeciencylevel 
    @LearnerID INT,
    @skill VARCHAR(50) OUTPUT
AS
BEGIN
    DECLARE @MaxProficiencyLevel INT;
    SELECT @MaxProficiencyLevel = MAX(proficiency_level)
    FROM SkillProgression
    WHERE LearnerID = @LearnerID AND skill_name = @skill;
    SELECT @skill = skill_name
    FROM SkillProgression
    WHERE LearnerID = @LearnerID AND proficiency_level = @MaxProficiencyLevel AND skill_name = @skill;
END;
DECLARE @LearnerID INT = 3;  -- Example LearnerID
DECLARE @Skill VARCHAR(50);
EXEC Profeciencylevel @LearnerID, @Skill OUTPUT;
SELECT @Skill AS MostProficientSkill;




GO
CREATE PROCEDURE ProfeciencyUpdate
    @Skill VARCHAR(50),
    @LearnerID INT,
    @Level VARCHAR(50)
AS
BEGIN
    
    UPDATE SkillProgression
    SET proficiency_level = @Level
    WHERE LearnerID = @LearnerID AND skill_name = @Skill;
END;
 EXEC ProfeciencyUpdate @Skill = 'Java', @LearnerID = 1, @Level = 'Advanced';

  
  DROP PROCEDURE LeastBadge ;
GO
CREATE PROCEDURE LeastBadge
    @LearnerID INT OUTPUT
AS
BEGIN
    DECLARE @MinBadgeCount INT;
    SELECT @MinBadgeCount = MIN(BadgeCount)
    FROM (
        SELECT A.LearnerID, COUNT(A.BadgeID) AS BadgeCount
        FROM Achievement A
        GROUP BY A.LearnerID
    ) AS BadgeCounts;

    SELECT @LearnerID = A.LearnerID
    FROM Achievement A
    GROUP BY A.LearnerID
    HAVING COUNT(A.BadgeID) = @MinBadgeCount;

END;
DECLARE @LearnerID INT;
EXEC LeastBadge @LearnerID OUTPUT;
PRINT @LearnerID;




DROP PROCEDURE PreferedType;
GO
CREATE PROCEDURE PreferedType
    @type VARCHAR(50) OUTPUT
AS
BEGIN
    DECLARE @MaxCount INT;
    SELECT @MaxCount = MAX(PreferenceCount)
    FROM (
        SELECT preference AS LearningType, COUNT(*) AS PreferenceCount
        FROM LearningPreference
        GROUP BY preference
    ) AS Preferences;
    SELECT @type = LearningType
    FROM (
        SELECT preference AS LearningType, COUNT(*) AS PreferenceCount
        FROM LearningPreference
        GROUP BY preference
    ) AS Preferences
    WHERE PreferenceCount = @MaxCount;
    
END;

DECLARE @preferredType VARCHAR(50);
EXEC PreferedType @type = @preferredType OUTPUT;
PRINT @preferredType;  


GO
CREATE PROCEDURE AssessmentAnalytics
    @CourseID INT,
    @ModuleID INT
AS
BEGIN
    SELECT 
        CourseID,
        ModuleID,
        AVG(total_marks) AS AverageScore,
        COUNT(ID) AS TotalAssessments
    FROM 
        Assessments
    WHERE 
        (@CourseID IS NULL OR CourseID = @CourseID)
        AND (@ModuleID IS NULL OR ModuleID = @ModuleID) 
    GROUP BY 
        CourseID, ModuleID
    ORDER BY 
        CourseID, ModuleID;
END;
EXEC AssessmentAnalytics @CourseID = 2, @ModuleID = 2;

 drop PROCEDURE EmotionalTrendAnalysis ;

GO
CREATE PROCEDURE EmotionalTrendAnalysis
    @CourseID INT,
    @ModuleID INT,
    @TimePeriod datetime
AS
BEGIN
    SELECT 
        M.ModuleID ,
        M.CourseID,
        ef.emotional_state,
        ef. timestamp
        
    FROM   
        Modules M
    INNER JOIN 
        Course_enrollment ce ON  M.CourseID = ce.CourseID 
    INNER JOIN 
        Emotional_feedback ef ON ce. LearnerID = ef. LearnerID
  WHERE 
        M.CourseID = @CourseID
        AND M.ModuleID = @ModuleID
        AND ef.timestamp BETWEEN  @TimePeriod AND GETDATE()
    ORDER BY 
        ef.timestamp;
END;

EXEC EmotionalTrendAnalysis @CourseID = 2, @ModuleID = 2, @TimePeriod = '2024-11-01 00:00:00';
