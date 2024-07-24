package backend;

import haxegithub.GithubAPI;
import haxegithub.utils.*;

class EngineMain {
    public static final repoOwner:String = 'Fyrid19';
    public static final repoName:String = 'Proto-Engine-FNF';
    public static final repository = Repository.get(repoOwner, repoName);

    public static var savePath(get, never):String;

    /**
     * REPLACE THIS WITH YOUR INITIAL GITHUB COMMIT HASH IF YOU WANNA USE GITHUB COMMIT SHIT
     */ 
    private static var firstCommit:String = 'cc34b41d331660c28b532924aaa931f460441d63';

    inline public static function getRepoCommits():Int {
        var api = new GithubAPI();
        if (firstCommit != null || firstCommit != '') {
            api.request('repos/$repoOwner/$repoName/compare/$firstCommit...main');
            return api.json.total_commits + 1;
        } else {
            return 0;
        }
    }

    inline public static function getCurCommit() {
        var api = new GithubAPI();
        api.request('repos/$repoOwner/$repoName/commits');
        return api.json[0];
    }

    inline static function get_savePath() {
        var company = Application.current.meta.get('company');
        return company;
    }
}