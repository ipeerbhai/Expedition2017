using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartScoreSystem
{
    class Program
    {
        static void Main(string[] args)
        {
            Questions.ProjectQuestions myQuestions = new Questions.ProjectQuestions();
            var Articles = myQuestions.HowToFindArticles("forest", 5, DateTime.Now.Subtract(new TimeSpan(10, 0, 0, 0, 0)), DateTime.Now);
            Console.WriteLine("SmartScore executed.");
        }
    }
}
