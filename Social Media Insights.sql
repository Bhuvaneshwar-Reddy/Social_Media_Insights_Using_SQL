-- Social Media Insights: SQL Exploration of User Interactions and Profiles

-- Let us create a table named UserProfile which contains the basic details required in any social media platform.

-- CREATE TABLE UserProfile
-- This table stores user profile information, capturing various attributes and details of each user.

DROP TABLE IF EXISTS UserProfile;

CREATE TABLE UserProfile(
	UserProfileId INTEGER PRIMARY KEY AUTO_INCREMENT,
    UserName 	  VARCHAR(20) UNIQUE NOT NULL,
    Password 	  VARCHAR(20) NOT NULL,
    Email	      VARCHAR(40) UNIQUE NOT NULL,
    FirstName     VARCHAR(50) NOT NULL,
    MiddleName    VARCHAR(50),
    LastName      VARCHAR(50) NOT NULL,
    CreatedDTTM   DATETIME NOT NULL default NOW(),
    UpdatedDTTM   DATETIME,
    IsDeleted     BIT NOT NULL DEFAULT 0
);

-- Columns:
-- UserProfileId: A unique identifier for each user, automatically incremented.
-- UserName: The chosen username of the user, must be unique and cannot be empty.
-- Password: The user's password for account access, stored securely.
-- Email: The user's email address, must be unique and valid.
-- FirstName: The first name of the user.
-- MiddleName: The optional middle name of the user.
-- LastName: The last name of the user.
-- CreatedDTTM: Records the date and time when the user profile was created.
-- UpdatedDTTM: Records the date and time when the user profile was last updated.
-- IsDeleted: A flag indicating whether the user profile has been deleted (0 for not deleted, 1 for deleted).

-- This table serves as a foundation for user accounts and profiles. It holds essential user information
-- such as names, contact details, and creation timestamps. The unique constraints on UserName and Email
-- ensure that each user's identity is distinct, preventing duplicates. The IsDeleted column provides an
-- option for soft deletion, allowing for better data management.

-- The UserProfileId, UserName, and Email columns play crucial roles in identifying and verifying users
-- throughout the application.


INSERT INTO UserProfile(UserName,Password,Email,FirstName,LastName)
VALUES('John Doe','johndoe123','john.doe@example.com','John','Doe');
INSERT INTO UserProfile(UserName,Password,Email,FirstName,LastName)
VALUES('Jane Smith','janesmith456','jane.smith@example.com','Jane','Smith');
INSERT INTO UserProfile(UserName,Password,Email,FirstName,LastName)
VALUES('Alex Johnson','alex1234',' alex.johnson@example.com','Alex','Johnson');
INSERT INTO UserProfile(UserName,Password,Email,FirstName,LastName)
VALUES('Emily Brown','emily5678','emily.brown@example.com','Emily','Brown');

SELECT * from UserProfile;

-- CREATE TABLE UserProfileExt
-- This table extends user profiles with additional details, enhancing the user experience and relationships.

DROP TABLE IF EXISTS UserProfileExt;

CREATE TABLE UserProfileExt(
	UserProfileExtID INTEGER PRIMARY KEY AUTO_INCREMENT,
    UserProfileID 	 INTEGER UNIQUE NOT NULL, -- Establish 1-1 relationship by adding UNIQUE constraint
    ProfileImage 	 VARCHAR(100),
    PhoneNo			 VARCHAR(12),
    Website			 VARCHAR(50),
    HeadLine		 VARCHAR(50),
    Country			 VARCHAR(50),
    Bio 		 TEXT,
    CONSTRAINT fk_userprofile_id FOREIGN KEY(UserProfileID) REFERENCES UserProfile(UserProfileID)
);

-- Columns:
-- UserProfileExtID: A unique identifier for each extended profile, automatically incremented.
-- UserProfileID: The reference to the corresponding user profile, ensuring a one-to-one relationship.
-- ProfileImage: The path to the user's profile image.
-- PhoneNo: The user's phone number.
-- Website: The user's personal or professional website URL.
-- HeadLine: A brief headline describing the user's role or expertise.
-- Country: The user's country of residence.
-- Bio: A more comprehensive summary or bio about the user.
-- fk_userprofile_id: Foreign key constraint referencing the UserProfile table to maintain integrity.

-- This table adds depth to user profiles by allowing users to provide more information about themselves.
-- The one-to-one relationship established through UserProfileID ensures that each user has a unique extended
-- profile. Additional attributes like ProfileImage, PhoneNo, and Website contribute to a richer profile,
-- while the Bio column allows users to share more about themselves.

-- The fk_userprofile_id constraint maintains a solid link between the user profile and their extended details,
-- guaranteeing that each extended profile belongs to a valid user.

-- The UserProfileExtID column acts as a key to access and manage these extended profile entries.


-- Insert example data into UserProfileExt table

-- User Profile ID: 1
INSERT INTO UserProfileExt (UserProfileID, ProfileImage, PhoneNo, Website, HeadLine, Country, Bio)
VALUES (1, '/storage/1/image.png', '7221455555', 'www.johndoe.com', 'Web Developer', 'United States', 'Passionate about creating user-friendly web experiences.');

-- User Profile ID: 2
INSERT INTO UserProfileExt (UserProfileID, ProfileImage, PhoneNo, Website, HeadLine, Country, Bio)
VALUES (2, '/storage/2/image.png', '7334567890', 'www.janesmith.com', 'Graphic Designer', 'Canada', 'Bringing ideas to life through visual storytelling.');

-- User Profile ID: 3
INSERT INTO UserProfileExt (UserProfileID, ProfileImage, PhoneNo, Website, HeadLine, Country, Bio)
VALUES (3, '/storage/3/image.png', '7445678901', 'www.alexjohnson.com', 'Data Analyst', 'United Kingdom', 'Turning data into actionable insights for decision-making.');

-- User Profile ID: 4
INSERT INTO UserProfileExt (UserProfileID, ProfileImage, PhoneNo, Website, HeadLine, Country, Bio)
VALUES (4, '/storage/4/image.png', '7556789012', 'www.emilybrown.com', 'Content Creator', 'Australia', 'Crafting compelling stories that resonate with audiences.');

SELECT * FROM UserProfileExt;

-- If we want to display both the UserProfile data as well as UserProfileExt data, we can combine and display using JOINS.
-- Here are some of the different JOINS that are available in SQL.

SELECT * FROM UserProfile As u
INNER JOIN UserProfileExt As ux ON (u.UserProfileId=ux.UserProfileID);

SELECT * FROM UserProfile As u
LEFT JOIN UserProfileExt As ux ON (u.UserProfileId=ux.UserProfileID);

SELECT * FROM UserProfile As u
Right JOIN UserProfileExt As ux ON (u.UserProfileId=ux.UserProfileID);

SELECT * FROM UserProfile As u
LEFT JOIN UserProfileExt As ux ON (u.UserProfileId=ux.UserProfileID)
UNION
SELECT * FROM UserProfile As u
RIGHT JOIN UserProfileExt As ux ON (u.UserProfileId=ux.UserProfileID);

-- Create table UserConnections
-- This table manages relationships and connections between users.
 
DROP TABLE IF EXISTS UserConnections;

CREATE TABLE UserConnections (
    UserOne      INTEGER NOT NULL,
    UserTwo      INTEGER NOT NULL,
    IsConnection BIT NOT NULL,
    IsFollower   BIT NOT NULL,
    ConnectedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_userone FOREIGN KEY (UserOne) REFERENCES UserProfile (UserProfileID),
    CONSTRAINT fk_usertwo FOREIGN KEY (UserTwo) REFERENCES UserProfile (UserProfileID)
);

-- Columns:
-- UserOne: Represents the ID of the first user in the connection.
-- UserTwo: Represents the ID of the second user in the connection.
-- IsConnection: Indicates whether a connection exists between the users (1 for connected, 0 for not connected).
-- IsFollower: Indicates whether UserOne follows UserTwo (1 for following, 0 for not following).
-- ConnectedDTTM: Records the date and time of the connection.
-- fk_userone: Foreign key constraint referencing the UserProfile table to ensure the validity of UserOne.
-- fk_usertwo: Foreign key constraint referencing the UserProfile table to ensure the validity of UserTwo.

-- This table allows us to represent connections and followership between users in a structured way.
-- For instance, it can be used to show who follows whom and who is connected to whom.
-- The IsConnection and IsFollower columns provide flexibility in representing different types of relationships.

-- Insert example data into UserConnections table

-- User One follows User Two
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (1, 2, 0, 1, NOW());

-- User Two follows User One (both are connected)
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (2, 1, 1, 1, NOW());

-- User One follows User Three
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (1, 3, 0, 1, NOW());

-- User Three follows User Two
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (3, 2, 0, 1, NOW());

-- User Three and User Four follow each other (both are connected)
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (3, 4, 1, 1, NOW());
INSERT INTO UserConnections (UserOne, UserTwo, IsConnection, IsFollower, ConnectedDTTM)
VALUES (4, 3, 1, 1, NOW());

SELECT * from UserConnections;

/* Here's how the "IsConnection" and "IsFollower" attributes work in this project:

- If user 1 follows user 2, the "IsFollower" attribute is set to 1.
- However, if user 2 hasn't followed back, the "IsConnection" attribute remains 0.
- When user 2 follows back user 1, the "IsConnection" status changes to 1.
- At this point, the "IsConnection" value for user 1 is also updated to 1, showing a mutual connection.
- In the context of this project, once a mutual connection (IsConnection) is established between two users, their respective IsFollower attribute will be set to 0. 
- This helps differentiate between users who mutually follow each other and those who are followed but haven't followed back.
*/

-- Update IsConnection status for all users when both users have followed each other
UPDATE UserConnections AS uc1
JOIN UserConnections AS uc2 ON uc1.UserOne = uc2.UserTwo AND uc1.UserTwo = uc2.UserOne
JOIN UserProfile AS u1 ON uc1.UserOne = u1.UserProfileID
JOIN UserProfile AS u2 ON uc1.UserTwo = u2.UserProfileID
SET uc1.IsConnection = 1,uc1.IsFollower=0,uc1.IsFollower=0
WHERE uc1.IsFollower = 1 AND uc2.IsFollower = 1;

SELECT * FROM UserConnections;

-- Next, we'll create a new table named 'post' to store the information about the posts users share on the social media platform.

DROP TABLE IF EXISTS post;

CREATE TABLE post (
    PostID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    Content TEXT NOT NULL,
    PostedBy INTEGER NOT NULL,
    PostedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postedBy FOREIGN KEY (PostedBy) REFERENCES UserProfile(UserProfileID)
);

/* This query creates a table named "post" to store user-generated posts:

- "PostID" serves as the primary key and auto-increments for each new post.
- "Title" is a text field of up to 200 characters, required to contain the post's title.
- "Content" is a text field, mandatory to hold the post's content.
- "PostedBy" is an integer, indicating the user responsible for the post, and it cannot be empty.
- "PostedDTTM" is a datetime field set to the current time when a post is created.
- The "fk_postedBy" constraint establishes a foreign key relationship with the "UserProfile" table using the "PostedBy" field, ensuring referential integrity.
*/

-- Let us insert some data into this table

-- Insert example data into the 'post' table

INSERT INTO post (Title, Content, PostedBy)
VALUES ('Exploring New Horizons', 'Just arrived at a breathtaking mountain peak!', 1);

INSERT INTO post (Title, Content, PostedBy)
VALUES ('Sunset Magic', 'Witnessed a stunning sunset by the beach.', 2);

INSERT INTO post (Title, Content, PostedBy)
VALUES ('Foodie Adventure', 'Indulging in local cuisine at a hidden gem restaurant.', 3);

INSERT INTO post (Title, Content, PostedBy)
VALUES ('City Lights', 'The vibrant cityscape at night is truly mesmerizing.', 1);

INSERT INTO post (Title, Content, PostedBy)
VALUES ('Artistic Creations', 'Sharing my latest art project with everyone.', 4);

INSERT INTO post (Title, Content, PostedBy)
VALUES ('Fitness Journey', 'Reached a new personal best at the gym!', 2);

SELECT * FROM post;

/* Here, we're creating a table named 'postlike' which handles user engagement with posts, 
specifically tracking which user liked a post authored by another user. 
This allows us to monitor and record the interactions between users and their posts. */

DROP TABLE IF EXISTS postlike;

CREATE TABLE PostLike (
    PostLikeID INTEGER PRIMARY KEY AUTO_INCREMENT,
    PostID INTEGER NOT NULL,
    LikedBy INTEGER NOT NULL,
    ActionTDDM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postid FOREIGN KEY(PostID) REFERENCES Post(PostID),
    CONSTRAINT fk_likedby FOREIGN KEY(LikedBy) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT unq UNIQUE(PostID, LikedBy)
);
/* Columns:

- "PostLikeID" is the primary key, automatically incremented for each new like.
- "PostID" represents the associated post's identifier and cannot be empty.
- "LikedBy" denotes the user who liked the post and is required.
- "ActionTDDM" signifies the timestamp of the liking action, with a default value of the current time.
- The "fk_postid" foreign key enforces referential integrity by linking "PostID" to the "Post" table's primary key.
- Similarly, the "fk_likedby" foreign key establishes a link between "LikedBy" and "UserProfileID" in the "UserProfile" table.
- The "unq" constraint ensures that each user can like a specific post only once, preventing duplicate likes.
*/

-- Let us Insert some data into the table.

INSERT INTO PostLike (PostID, LikedBy)
VALUES (1, 2);

INSERT INTO PostLike (PostID, LikedBy)
VALUES (2, 1);

INSERT INTO PostLike (PostID, LikedBy)
VALUES (3, 1);

INSERT INTO PostLike (PostID, LikedBy)
VALUES (4, 3);

INSERT INTO PostLike (PostID, LikedBy)
VALUES (1, 4);

INSERT INTO PostLike (PostID, LikedBy)
VALUES (1, 3);

select * from PostLike;

/* In this step, we are introducing a new table called 'postcomment' designed to store information about user comments on each other's posts.
This includes details about who left the comment, the post being commented on, as well as the potential inclusion of nested comments. 
This table structure facilitates the organization of comment interactions within the social media platform. */

DROP TABLE IF EXISTS postcomment;

CREATE TABLE PostComment (
    PostCommentID INTEGER PRIMARY KEY AUTO_INCREMENT,
    PostID INTEGER NOT NULL,
    CommentForCommentID INTEGER,
    CommentText TEXT NOT NULL,
    CommentedBy INTEGER NOT NULL,
    CommentedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postid_postcomment FOREIGN KEY(PostID) REFERENCES Post(PostID),
    CONSTRAINT fk_commentedby FOREIGN KEY(CommentedBy) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT fk_commentforcomment FOREIGN KEY(CommentForCommentID) REFERENCES PostComment(PostCommentID)
);

/* Columns Description:

- 'PostCommentID' serves as the primary key, automatically incremented for each new comment.
- 'PostID' is a mandatory reference to the post being commented on.
- 'CommentForCommentID' refers to the parent comment if applicable, allowing a comment thread structure.
- 'CommentText' stores the text content of the comment, which cannot be empty.
- 'CommentedBy' indicates the user who wrote the comment and is a required field.
- 'CommentedDTTM' captures the timestamp of the comment creation with the current time as the default.
- 'fk_postid_postcomment' enforces referential integrity by relating 'PostID' to the 'Post' table's primary key.
- 'fk_commentedby' establishes a link between 'CommentedBy' and 'UserProfileID' in the 'UserProfile' table.
- 'fk_commentforcomment' establishes a self-referential foreign key relationship, linking 'CommentForCommentID' to 'PostCommentID' to represent parent-child comment relationships.
*/

-- Let us insert some data into this table

INSERT INTO PostComment (PostID, CommentText, CommentedBy)
VALUES (1, 'Great view from the top!', 3);

INSERT INTO PostComment (PostID, CommentText, CommentedBy)
VALUES (2, 'Beautiful sunset captured!',1);

INSERT INTO PostComment (PostID, CommentText, CommentedBy)
VALUES (3, 'Delicious looking meal!', 2);

INSERT INTO PostComment (PostID, CommentText, CommentedBy)
VALUES (4, 'City lights are mesmerizing.', 4);

-- Nested comments
INSERT INTO PostComment (PostID, CommentText, CommentedBy, CommentForCommentID)
VALUES (2, 'Indeed, it was breathtaking!', 3, 2);

INSERT INTO PostComment (PostID, CommentText, CommentedBy, CommentForCommentID)
VALUES (4, 'I agree, the cityscape is incredible!', 2, 4);

SELECT * FROM PostComment;

--  Let's proceed to address a few questions by formulating suitable queries.

-- Problem 1: Write a query to retrieve the names of Users who have a connection with John Doe

-- Solved using Subqueries

SELECT UserName FROM UserProfile
WHERE UserProfileID IN (
SELECT UserTwo FROM Userconnections
WHERE UserOne = (SELECT UserProfileID FROM UserProfile WHERE UserName = 'John Doe') AND IsConnection = 1);

-- Solved using JOINS

SELECT u.UserName
FROM UserProfile AS u
INNER JOIN UserConnections AS uc ON (u.UserProfileID = uc.UserTwo
AND uc.UserOne = (SELECT UserProfileID FROM UserProfile WHERE UserName ='John Doe')
AND uc.IsConnection = 1);

-- Problem-2: Write a query to retrieve all the followers of 'a'
-- Note: Followers include connections + only followers

-- Using Subqueries

SELECT UserName FROM UserProfile WHERE UserProfileId IN 
(SELECT UserTwo FROM UserConnections WHERE UserOne = (SELECT UserProfileID FROM UserProfile WHERE UserName = 'John Doe') AND 
(IsConnection = 1 OR Isfollower = 1));

-- Using JOINS

SELECT u.UserName
FROM userprofile u 
INNER JOIN userconnections uc ON u.UserProfileId = uc.UserTwo
WHERE uc.UserOne = (SELECT UserProfileId FROM userprofile WHERE UserName = 'John Doe') 
AND (uc.IsConnection=1 OR uc.IsFollower=1);

-- Problem 3: Write a query to retreive all the posts posted by 'John Doe'

SELECT * FROM post
WHERE PostedBy = (SELECT UserProfileID FROM UserProfile WHERE UserName='John Doe');

-- Problem 4: Write a query to retreive the number of likes for PostId = 1

SELECT count(*) AS no_of_likes FROM PostLike
WHERE PostID=1;

-- Problem 5. Display the total likes for the posts posted by 'Jane Smith'

SELECT COUNT(LikedBy) FROM PostLike AS pl
INNER JOIN UserProfile AS u ON (pl.PostID=u.UserProfileID)
WHERE u.UserName = 'Jane Smith';

-- Problem 6. Display the PostID and Likes count for the posts posted by 'John Doe'

SELECT PostID,count(LikedBy) AS No_of_Likes FROM PostLike AS pl
INNER JOIN UserProfile AS u ON (pl.PostID=u.UserProfileID)
WHERE u.UserProfileID = 1;

-- Problem 7. Display the name of the user with maximum post likes.

SELECT u.UserName, COUNT(LikedBy) AS LikeCount
FROM PostLike AS pl
INNER JOIN UserProfile AS u ON (pl.PostID = u.UserProfileID)
GROUP BY u.UserName 
ORDER BY u.UserName DESC
LIMIT 1;

-- Problem 8. Display the users with maximum posts

SELECT * FROM
(SELECT a.*, RANK() OVER(ORDER BY No_Of_Posts) AS `RANK` FROM
(SELECT u.UserName, COUNT(PostedBy) AS No_Of_Posts
FROM post AS p
INNER JOIN UserProfile AS u ON (p.PostedBy = u.UserProfileID)
GROUP BY UserName
ORDER BY No_Of_Posts DESC)a)b
WHERE `RANK`=1;

/* Query Conclusion and Insights */

/* In this exploration, we've unraveled the inner workings of social media data using SQL queries. 
The interconnected tables symbolize user relationships, posts, and interactions. 
By addressing questions like identifying connections, counting likes, and finding top users, 
we've demonstrated the power of data analysis in deciphering user behavior. 
This illustrates how complex systems like social media platforms rely on structured data for insights. 
As you journey further, consider delving into advanced challenges, such as tracking trends and user engagement over time.
Keep querying and discovering the secrets beneath the surface of digital connections! 🌐📊 
*/