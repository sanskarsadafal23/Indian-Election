----------------------------#data cleaning------------------------------

create database election;
use election;
create table constituencywise_details
( sn int ,
candidate varchar(30),
party varchar(30),
evmvotes int,
postalvotes int,
totalvotes int,
percentage_of_votes int,
constituency_id varchar(30)
)
select * from constituencywise_results;
select `Constituency ID` from constituencywise_results;
create table statewise_results
(
Constituency varchar(20),
	Const_No int,
	Parliament_Constituency	varchar(30),
    Leading_Candidate varchar(30),
	Trailing_Candidate varchar(30),
	Margin int,
	Can_Status varchar(20),
	State_ID varchar(20),
	State varchar(15)
    );
select State from statewise_results;
        ---------------------------- #Problem Statement----------------------------------------

 
 #1 Total Seats.
 
SELECT 
    COUNT(DISTINCT `Parliament Constituency`) AS total_seats
FROM
    constituencywise_results;


#2  What are the total number of seats available for election in each states.

SELECT 
    s.State AS state_name,
    COUNT(cr.`Parliament Constituency`) AS total_seats
FROM
    constituencywise_results cr
        INNER JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
        INNER JOIN
    states s ON sr.`State_ID` = s.`State ID`
GROUP BY s.State


#3  Total Seats Won By NDA Alliance

SELECT 
    SUM(CASE
        WHEN
            Party IN ('Bharatiya Janata Party - BJP' , 'Telugu Desam - TDP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'AJSU Party - AJSUP',
                'Apna Dal (Soneylal) - ADAL',
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD',
                'Sikkim Krantikari Morcha - SKM')
        THEN
            Won
        ELSE 0
    END) AS NDA_Total_Seats_Won
FROM
    partywise_results;
    
    
  #4 Seats Won by NDA Alliance Parties
    
    SELECT 
    Party as Party_Name,
    Won as Seats_Won
FROM 
    partywise_results
WHERE 
    Party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC


  # 5 India National Development Inclusive Alliance(I.N.D.I.A)

SELECT 
    SUM(CASE
        WHEN
            Party IN ('Indian National Congress - INC' , 'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
        THEN
            Won
        ELSE 0
    END) AS INDIA_Total_Seats_Won
FROM
    partywise_results;
    
    
  #6 Seats Won BY I.N.D.I.A Alliance

SELECT 
    Party AS Party_Name, Won AS Seats_Won
FROM
    partywise_results
WHERE
    party IN ('Indian National Congress - INC' , 'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Nat`Jammu & Kashmir National Conference - JKN',
        'Jharkhand Mukti Morcha - JMM',
        'Jammu & Kashmir National Conference - JKN',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK')
ORDER BY Seats_Won DESC;


#7 Add new column field in table partywise_results to get the Party Allianz as NDA,I.N.D.I.A and other
      
      ALTER TABLE partywise_results
      ADD party_alliance VARCHAR(50);
	UPDATE partywise_results 
SET 
    party_alliance = 'I.N.D.I.A'
WHERE
    Party IN ('Indian National Congress - INC' , 'Aam Aadmi Party - AAAP',
        'All India Trinamool Congress - AITC',
        'Bharat Adivasi Party - BHRTADVSIP',
        'Communist Party of India  (Marxist) - CPI(M)',
        'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
        'Communist Party of India - CPI',
        'Dravida Munnetra Kazhagam - DMK',
        'Indian Union Muslim League - IUML',
        'Jammu & Kashmir National Conference - JKN',
        'Jharkhand Mukti Morcha - JMM',
        'Kerala Congress - KEC',
        'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
        'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
        'Rashtriya Janata Dal - RJD',
        'Rashtriya Loktantrik Party - RLTP',
        'Revolutionary Socialist Party - RSP',
        'Samajwadi Party - SP',
        'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
        'Viduthalai Chiruthaigal Katchi - VCK');
UPDATE partywise_results 
SET 
    party_alliance = 'NDA'
WHERE
    Party IN ('Bharatiya Janata Party - BJP' , 'Telugu Desam - TDP',
        'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS',
        'AJSU Party - AJSUP',
        'Apna Dal (Soneylal) - ADAL',
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS',
        'Janasena Party - JnP',
        'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV',
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD',
        'Sikkim Krantikari Morcha - SKM');
UPDATE partywise_results 
SET 
    party_alliance = 'OTHER'
WHERE
    party_alliance IS NULL;
    
    
    #8 Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
   
   SELECT 
    party_alliance, SUM(Won)
FROM
    partywise_results
GROUP BY party_alliance;
   
    
    #9  Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?
   
   SELECT 
    cr.`Winning Candidate`,
    p.Party,
    p.party_alliance,
    cr.`Total Votes`,
    cr.Margin,
    cr.`Constituency Name`,
    s.State
FROM
    constituencywise_results cr
        JOIN
    partywise_results p ON cr.`Party ID` = p.`Party ID`
        JOIN
    statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
        JOIN
    states s ON sr.State_ID = s.`State ID`
WHERE
    s.State = 'Uttar Pradesh'
        AND cr.`Constituency Name` = 'AMETHI';


#10  What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

SELECT 
    cd.evmvotes,
    cd.postalvotes,
    cd.totalvotes,
    cd.candidate,
    cr.`Constituency ID`
    from constituencywise_results cr join constituencywise_details cd
    on cr.`Constituency Name` = cd.constituency_id
    where cr.`Constituency ID` = 'AMETHI';
    
    
    #11 Which parties won the most seats in s State, and how many seats did each party win?
    
    SELECT 
    p.Party,
    COUNT(cr.`Constituency ID`) AS Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.`State ID`
WHERE 
    s.State = 'Andhra Pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;
    
    
    # 12 What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024
    
    SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.`Party ID` = p.`Party ID`
JOIN 
    statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.`State ID`
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  
GROUP BY 
    s.State
ORDER BY 
    s.State;

# 13 Which candidate received the highest number of EVM votes in each constituency (Top 10)?


SELECT 
    cr.`Constituency Name`,
    cd.constituency_id,
    cd.candidate,
    cd.evmvotes
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.constituency_id = cr.`Constituency ID`
WHERE 
    cd.evmvotes = (
        SELECT MAX(cd1.evmvotes)
        FROM constituencywise_details cd1
        WHERE cd1.constituency_id = cd.constituency_id
    )
ORDER BY 
    cd.evmvotes DESC;
    
    
    # 14  Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

    WITH RankedCandidates AS (
    SELECT 
        cd.constituency_id,
        cd.candidate,
        cd.party,
        cd.evmvotes,
        cd.postalvotes,
        cd.evmvotes + cd.postalvotes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.constituency_id ORDER BY cd.evmvotes + cd.postalvotes DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.constituency_id = cr.`Constituency ID`
    JOIN 
        statewise_results sr ON cr.`Parliament Constituency` = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.`State ID`
    WHERE 
        s.State = 'Maharashtra'
)

SELECT 
    cr.`Constituency Name`,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.`Constituency ID`
GROUP BY 
    cr.`Constituency Name`
ORDER BY 
    cr.`Constituency Name`;












  


