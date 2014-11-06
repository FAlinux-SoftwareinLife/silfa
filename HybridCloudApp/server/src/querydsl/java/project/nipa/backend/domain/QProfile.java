package project.nipa.backend.domain;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;
import javax.annotation.Generated;
import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QProfile is a Querydsl query type for Profile
 */
@Generated("com.mysema.query.codegen.EntitySerializer")
public class QProfile extends EntityPathBase<Profile> {

    private static final long serialVersionUID = 920760038L;

    public static final QProfile profile = new QProfile("profile");

    public final StringPath authorize = createString("authorize");

    public final StringPath email = createString("email");

    public final ListPath<File, QFile> files = this.<File, QFile>createList("files", File.class, QFile.class, PathInits.DIRECT2);

    public final StringPath gender = createString("gender");

    public final StringPath language = createString("language");

    public final StringPath photo = createString("photo");

    public final StringPath userId = createString("userId");

    public QProfile(String variable) {
        super(Profile.class, forVariable(variable));
    }

    public QProfile(Path<? extends Profile> path) {
        super(path.getType(), path.getMetadata());
    }

    public QProfile(PathMetadata<?> metadata) {
        super(Profile.class, metadata);
    }

}

