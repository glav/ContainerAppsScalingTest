namespace TestContainerApp
{
    public class ApiResultModel
    {
        public DateTime DateTime { get; set; }

        public string? Summary { get; set; }

        public string Version { get; set; }

        public int WaitCountInTicks { get; set; }
    }
}