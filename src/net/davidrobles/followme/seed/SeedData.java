package net.davidrobles.followme.seed;

import de.svenjacobs.loremipsum.LoremIpsum;
import net.davidrobles.followme.dao.JdbcFollowMeDao;
import net.davidrobles.followme.models.Tweet;
import net.davidrobles.followme.models.User;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class SeedData
{
    private static final Random RND = new Random();
    private static final LoremIpsum IPSUM = new LoremIpsum();

    private static final String[] FIRST_NAMES;
    private static final String[] LAST_NAMES;
    private static final String[] EMAILS;

    private JdbcFollowMeDao dao;

    public SeedData() {
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/followme");
        ds.setUsername("root");
        ds.setPassword("Darc23");
        dao = new JdbcFollowMeDao();
        dao.setJdbc(new NamedParameterJdbcTemplate(ds));
    }

    static {
        FIRST_NAMES = toArray("first_names.txt");
        LAST_NAMES = toArray("last_names.txt");
        EMAILS = toArray("emails.txt");
    }

    private static String[] toArray(String filename) {
        List<String> all = new ArrayList<String>();
        try {
            Scanner scanner = new Scanner(new File("seed/" + filename));
            while (scanner.hasNextLine())
                all.add(scanner.nextLine());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return all.toArray(new String[all.size()]);
    }
    
    private static void createRelationships() {
//        List<User> users = User.getAll();
//        for (User user : users) {
//            User rndUser = users.get(RND.nextInt(users.size()));
//            if (user.getId() != rndUser.getId())
//                user.follow(rndUser);
//        }
    }

    private void seedUsers()
    {
        dao.save(new User("davidrobles", "davidrobles", "drobles@gmail.com", "David Robles"));
        dao.save(new User("nataliacaballero", "nataliacaballero", "nattycaballero@gmail.com", "Natalia Caballero"));
        dao.save(new User("ben.royall", "ben.royall", "ben.royall@gmail.com", "Ben Royall"));
        dao.save(new User("acarrillomodderman", "acarrillomodderman", "acarrillomodderman@gmail.com", "Alexandra Cm"));
        dao.save(new User("StephenSONeil", "StephenSONeil", "christophe.mansfield@gmail.com", "Steve Smith"));
        dao.save(new User("mgraffg", "mgraffg", "mgraffg@gmail.com", "Mario Graff"));
        dao.save(new User("nielsvanhoorn", "nielsvanhoorn", "nielsvanhoorn@gmail.com", "Niels van Hoorn"));
        dao.save(new User("Klovli", "Klovli", "Klovli@gmail.com", "Alex Holmes"));
        dao.save(new User("alisonchiu", "alisonchiu", "alisonchiu@gmail.com", "Alison Hsin-Yi"));
        dao.save(new User("auasch", "auasch", "auasch@gmail.com", "Anna Schoiswohl"));
        dao.save(new User("acoldenbjerg", "acoldenbjerg", "acoldenbjerg@gmail.com", "Anne Cathrine"));
        dao.save(new User("chrispaarup", "chrispaarup", "chrispaarup@gmail.com", "Chris Pickering"));
        dao.save(new User("christianeskehansen", "christianeskehansen", "christianeskehansen@gmail.com", "Christian Eske"));
        dao.save(new User("amanfel", "amanfel", "amanfel@gmail.com", "Amanda Feldman"));
        dao.save(new User("davidgwebb", "davidgwebb", "davidgwebb@gmail.com", "David Webb"));
        dao.save(new User("agbatiz", "agbatiz", "agbatiz@gmail.com", "Andie Garza"));
        dao.save(new User("amneft", "amneft", "amneft@gmail.com", "Adam Neft"));
        dao.save(new User("SchlackDizzle", "SchlackDizzle", "SchlackDizzle@gmail.com", "Adam Schlackman"));
        dao.save(new User("RachelPocahontas", "RachelPocahontas", "RachelPocahontas@gmail.com", "Rachel Barros"));
        dao.save(new User("bronsonali", "bronsonali", "bronsonali@gmail.com", "Ali Bronson"));
        dao.save(new User("acp21178", "acp21178", "acp21178@gmail.com", "Andrew Pennacchio"));
        dao.save(new User("andrewychoo", "andrewychoo", "andrewychoo@gmail.com", "Andy Choo"));
        dao.save(new User("Thrillhelm", "Thrillhelm", "Thrillhelm@gmail.com", "Andy Wilhelm"));

//
//        System.out.println("************");
//        System.out.println(" SEED USERS");
//        System.out.println("************");
//
//        int i = 0;
//
//        while (i < 50)
//        {
//            String firstName = FIRST_NAMES[RND.nextInt(FIRST_NAMES.length)];
//            String secondName = LAST_NAMES[RND.nextInt(LAST_NAMES.length)];
//            String username = (firstName.charAt(0) + secondName).toLowerCase();
//            String password = username;
//            String email = username + "@" + EMAILS[RND.nextInt(EMAILS.length)];
//            String name = firstName + " " + secondName;
//            User user = new User(username, password, email, name);
//
//            if (dao.save(user)) {
//                System.out.println(user);
//                i++;
//            }
//        }
    }

    private void seedTweets()
    {
        System.out.println("*************");
        System.out.println(" SEED TWEETS");
        System.out.println("*************");

        for (int i = 0; i < 50; i++) {
            int nWords = RND.nextInt(20) + 1;
            List<User> users = dao.getUsers();
            User user = users.get(RND.nextInt(users.size()));
            Tweet tweet = new Tweet(user.getId(), IPSUM.getWords(nWords));
            if (i % 10 == 0)
                System.out.println("Saving tweet " + i);
            dao.save(tweet);
        }
    }

    private void seedRelationships()
    {
        System.out.println("***************");
        System.out.println(" RELATIONSHIPS");
        System.out.println("***************");

        List<User> users = dao.getUsers();

        for (int i = 0; i < 10; i++) {

            User user1 = users.remove(RND.nextInt(users.size()));
            User user2 = users.remove(RND.nextInt(users.size()));
            dao.addRelationship(user1.getId(), user2.getId());
        }
    }

    public static void main(String[] args) {
//        System.out.println(new Date().getTime());
//        System.out.println(time);
        SeedData seedData = new SeedData();
//        seedData.dao.deleteAllUsers();
        seedData.seedUsers();
        seedData.seedTweets();
        seedData.seedRelationships();
//        createRelationships();
    }
}
