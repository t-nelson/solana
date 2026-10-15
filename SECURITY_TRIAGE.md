## Motivation
This document intends to provide some general guidelines for how we approach triaging security
issues at Anza. It does not purport to be prescriptive as the subject revolves around situations
that are emergent, dynamic and complex in nature. Treat this content as guidance and try to uphold
its spirit when applying your own judgement in response to incidents.

## Discovery
Security issues tend to make themselves known in a few common ways.
* Github Private Vulnerability Reporting (GHSAs)
* As consequence of normal development practices
* In the course of debugging live cluster anomalies
* Active attack

### GHSAs
Github Security Advisories are by far the most common way Anza interacts with security issues. They
are how we communicate with external security researchers, be they independents motivated by the
our bounty program or auditors affiliated with one of our contracted security firms. GHSAs are also
the preferred venue for reporting internally discovered vulnerabilties.

### Daily Maintenance
All software contains latent bugs and some of those bugs will constitute security vulnerabilities.
The daily tasks of a competent developer will expose them to these bugs whether by reading to learn
a new area of the code base, improving existing code, developing new features or reviewing changes
proposed by others. While it is typically safe to address vulnerabilities introduced in uncommitted
changes during public review, those that have been committed to the code base and especially those
that have been deployed to the Mainnet Beta cluster, must be handled with the utmost care.

### Cluster Anomaly Debug Escalation


### Active Attack


## Information Hygiene
It should go without saying that controlling information is the key to a successful response.
Information in the wrong place can increase urgency, decrease timeliness, confuse, distract,
panic, etc. If there is ever a quesition of whether information should be shared in a given
situation, the safe default is always, "no".

### Rules of Thumb
* Always share as little information, with as few people, in as few venues as possible
* Once something is posted, the entire exposed audience knows about it. (You did not delete your
mistake fast enough)
* Do not assume that what is said in "private" will remain private

### Venue
Choosing the right venue is critical, especially early on. It is what is used to put walls around
the situation. Keep in mind though that walls keep information in, can also keep people out.

#### Origin
The venue where an issue is exposed isn't always under our control. Regardless, it is a fact
that must be considered for the remainder of the response. Its audience must be assumed to have all
information about the issue that has been posted there. If this happens to be an inopportune one, 
take pause before "cleaning up" the details to consider;
  * Will removing the discussion raise more suspicion than leaving it?
  * Are there ongoing public events that have made or will soon make the information apparent?
  * How well articulated is the issue?
  * Do you have platform permissions to delete everything necessary?
In many cases, the right choice is to simply drop the conversation in its place and move to a more
appropriate venue.

#### Triage
It is very important to chose **ONE** triage venue. Fragmenting the conversation only slows things
down with confusion and duplicate work. Under most circumstances, this will be a GHSA. Everyone
who may need access to the discussion will already have a Github account and be familiar with
interacting there. If the issue is extremely urgent, as in Mainnet Beta must be patched in a few
days at most

If you will be the initial disclosure of an issue, you should almost always start in a GHSA. The
exception being an issue that you are confident must be addressed in no more than a few days time.
In this case start with a private slack channel

### People
