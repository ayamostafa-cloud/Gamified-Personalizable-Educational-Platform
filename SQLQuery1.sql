CREATE TABLE Admin (
    AdminID INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100));
	
INSERT INTO Admin (AdminID, name, email)
VALUES 
(1, 'Marwa Johnson', 'marwa.johnson@example.com'),
(2, 'Alan Brown', 'alan.brown@example.com'),
(3, 'Emily Davis', 'emily.davis@example.com'),
(4, 'David Wilson', 'david.wilson@example.com'),
(5, 'Rachel Green', 'rachel.green@example.com');

ALTER TABLE LearnersGoals
ADD [Read] BIT NOT NULL DEFAULT 0;

ALTER TABLE ReceivedNotification
ADD [Read] BIT NOT NULL DEFAULT 0;


-- Update Timestamp
UPDATE [Notification]
SET [Timestamp] = GETDATE();

-- Add email column
ALTER TABLE Learner
ADD [email] VARCHAR(255);

-- Insert into ReceivedNotification
INSERT INTO [ReceivedNotification] ([NotificationId], [LearnerId], [IsRead])
VALUES (1, 2, 0);

-- Insert into LearnersGoals
INSERT INTO [LearnersGoals] ([LearnerId], [GoalId], [CompletionStatus])
VALUES (2, 5, 'In Progress');


