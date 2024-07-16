package backend;

import haxegithub.utils.*;

class EngineMain {
    public static final repoOwner:String = 'Fyrid19';
    public static final repoName:String = 'Proto-Engine-FNF';
    public static final repository = Repository.get(repoOwner, repoName);

    inline public static function getRepoCommits():Int {
        var api = new haxegithub.GithubAPI();
        api.request('repos/$repoOwner/$repoName/commits');
        return api.json.length;
    }
}