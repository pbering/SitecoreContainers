using Sitecore.Pipelines.HttpRequest;

namespace Website.Processors
{
    public class TestProcessor: HttpRequestProcessor
    {
        public override void Process(HttpRequestArgs args)
        {
            args.Context.Response.Write("<h1>Hello!</h1>");
        }
    }
}