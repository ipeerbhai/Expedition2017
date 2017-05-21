using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartScoreSystem.Questions
{
    public class ProjectQuestions
    {
        // I'm building a reddit search --> group program for articles.
        //  Let's assume I'm given a keyword, how do I find articles in our CSVs that contain that keyword.
        private const string m_DataFile = @"C:\Github\Expedition2017\data\NYTimesArticles.csv";
        private const string m_BaseURI = @"http://127.0.0.1:3000/"; // Change this to 
        //---------------------------------------------------------------------------------
        // Question -- how do I get the keywords from the website and give it back
        // articles to render?
        public void HowDoIGetTheKeywordDataAndReturnArticles()
        {

        }

        //---------------------------------------------------------------------------------
        // Question:
        //  How do I find articles that have each keyword in it?  Maybe filtered by count or date range?
        public List<int> HowToFindArticles(string keyWords, int count, DateTime startSearch, DateTime endSearch)
        {
            List<int> output = new List<int>();

            // break the keywords into a list, do "and" matching for each word.
            string[] keywordArray = keyWords.Split(' ');

            Dictionary<int, List<string>> OverlappingArticles = new Dictionary<int, List<string>>(); // will hold what we found foreach keyword
            foreach (string thisKeyword in keywordArray)
            {
                List<int> articleIndices = findIndicesByKeyword(thisKeyword); // will store the line number of each matching article.
                if (articleIndices.Count > 0 )
                {
                    foreach (int thisArticleIndex in articleIndices)
                    {
                        if (!OverlappingArticles.ContainsKey(thisArticleIndex))
                        {
                            OverlappingArticles.Add(thisArticleIndex, new List<string>() { thisKeyword });
                        }
                        else
                        {
                            OverlappingArticles[thisArticleIndex].Add(thisKeyword);
                        }
                    }
                }
            }

            // let's do the and logic part.  We look for value list counts that match the keyword array length.
            foreach (int thisArticleIndex in OverlappingArticles.Keys)
            {
                if (OverlappingArticles[thisArticleIndex].Count == keywordArray.Length)
                {
                    output.Add(thisArticleIndex); // the article contains all keywords.
                }
            }
            return (output);
        }

        //---------------------------------------------------------------------------------
        private List<int> findIndicesByKeyword(string thisKeyword)
        {
            List<int> output = new List<int>();
            // open the data file and read a line
            int lineRead = 0;
            string invariantKeyword = thisKeyword.ToLowerInvariant();
            using (FileStream fs = new FileStream(m_DataFile, FileMode.Open))
            {
                using (StreamReader sr = new StreamReader(fs))
                {
                    while (!sr.EndOfStream)
                    {
                        string thisLine = sr.ReadLine().ToLowerInvariant();
                        if (thisLine.Contains(invariantKeyword))
                        {
                            // we found the keyword.  Let's add the index.
                            output.Add(lineRead);
                        }
                        lineRead++;
                    }
                }
            }
            return (output);
        }
    }
}
