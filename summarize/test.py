from gensim.summarization import summarize

text = "President Donald Trump lands in Saudi Arabia Trump departed Washington as controversies swirled, all centering on the alleged ties between his campaign and Russia. For the most part, Trump's first day on foreign soil proceeded without major hiccups. Trump and King Salman bin Abdulaziz Al-Saud oversaw the signing on Saturday afternoon during an extended ceremony in a large gilded reception hall at the Royal Court. Multiple agreements between American and Saudi companies, including between the Saudi oil giant Aramco and various US firms, were inked during the event. Trump lauded the deals as Tremendous investments in the United States. That was a tremendous day. Tremendous investments in the United States. Hundreds of billions of dollars of investments into the United States and jobs, jobs, jobs, Trump said. Air Force One touched down earlier Saturday at the King Khalid airport in Riyadh, where Trump was greeted on a red carpet-bedecked tarmac by King Salman and other high-level Saudi officials. The grand welcome - which featured a military brass band and a fighter jet flyover - demonstrated just how highly anticipated Trump's arrival was to this Middle Eastern kingdom. It also seemed designed to flatter a President famous for a gilded lifestyle. In Riyadh, a five-story image of Trump's face was projected on the exterior of the Ritz Carlton hotel where he'll stay, and large billboards of Trump and King Salman lined the highway from the airport. Saturday will be the first night Trump sleeps in a property that isn't his own since becoming President. Great to be in Riyadh, Saudi Arabia, Trump tweeted shortly after his arrival. Trump and the 81-year-old Salman were seen in friendly conversation inside the Royal Terminal just after Trump touched down, and the two leaders shared a long drive from the airport to central Riyadh, where the President is staying. Shortly afterward, the pageantry continued inside the Saudi Royal Court, where Salman presented Trump with a gilded necklace and medal, the country's highest honor. After arriving with an escort of soldiers on horseback, Trump was welcomed to the court to the strains of the American national anthem. Joining Trump inside was a long parade of advisers, including Secretary of State Rex Tillerson, National Security Adviser H.R. McMaster, Commerce Secretary Wilbur Ross, chief of staff Reince Priebus, chief strategist Steve Bannon, senior advisers Ivanka Trump and Jared Kushner, press secretary Sean Spicer, and Trump's former bodyguard, Keith Schiller. Seated among the US advisers were the most powerful members of the Saudi government, including Deputy Crown Prince Mohammed bin Salman, the powerful son of the King who is advocating for major reforms in the kingdom. Also joining the President: first lady Melania Trump, who disembarked Air Force One alongside her husband Saturday in a flowing black jumpsuit with a gold belt. Like past US first ladies visiting Saudi Arabia, Melania Trump's hair was not covered in the local custom, and she shook Salman's hand upon arriving in the kingdom. When women from Western nations visit Saudi Arabia, they typically forgo a head covering. Trump issued sharp criticism of Michelle Obama, writing on Twitter that she'd Insulted Saudi citizens. On Saturday none of the women in Trump's delegation covered their hair, and there appeared to be little consternation from the many Saudi men who greeted them at the airport. Trump is embarking upon his first international trip at a moment of deep uncertainty for his young presidency. This week, the Justice Department named a special counsel to investigate Russian meddling in last year's election, including potential ties between Trump associates and Russian officials. Trump has fueled the Russia controversy by firing the man who was originally leading the Russia probe, FBI Director James Comey, in an apparent bid to stop the investigation. Trump is also accused of revealing high classified intelligence to Russian officials last week during an Oval Office meeting. It's increasingly clear that the swirl of controversy will shadow Trump during his stops in Saudi Arabia, Israel, Italy, the Vatican and Belgium. Appearing alongside his Saudi counterpart Saturday, Tillerson was asked about recent reports surrounding the Russia investigation. The question was a harbinger of questions to come for Trump's advisers on their first foreign swing, though Trump himself has not scheduled any news conferences for his entire nine-day trip. That's highly unusual for US presidents, who almost always take questions from reporters while embarking upon international travel. Trump remains popular in the Gulf, where leaders hope he'll take a harder line on Iran than Obama did. The President's visit comes as Iran's President Hassan Rouhani handily won re-election in what amounts to a victory for the Shiite nation's reformist camp. Saudi Arabia was opposed to the deal the Obama administration helped strike with Iran to curtail its nuclear program. While Trump campaigned as a strident opponent of the nuclear deal, his administration is still reviewing whether to scrap the accord. Leaders in the Gulf are also eager to hear Trump's plan for combating what they regard as Iran's destabilizing presence in Iraq, Syria and Yemen. During meetings this weekend, Trump will work to develop relationships with the leaders, with whom the United States hopes to partner to fight extremism. Trump is the first US president to choose a Muslim-majority nation for his first stop abroad, and his aides have said the decision was meant to rebut notions that Trump is anti-Muslim. Trump will deliver a major speech Sunday to the leaders of more than two dozen Muslim nations and is expected to urge countries to drive out extremists. An early draft of his speech does not contain the phrase Radical Islamic terror, a term which Trump has emphasized back home. The President edited the speech with his aides during the 14-hour journey from Washington, Spicer said."

print('Input text:')
print(text)

print('Summary:')
print(summarize(text))