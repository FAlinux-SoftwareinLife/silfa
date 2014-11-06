package project.nipa.backend.domain;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;
import javax.annotation.Generated;
import com.mysema.query.types.Path;


/**
 * QUser is a Querydsl query type for User
 */
@Generated("com.mysema.query.codegen.EntitySerializer")
public class QUser extends EntityPathBase<User> {

    private static final long serialVersionUID = -958982226L;

    public static final QUser user = new QUser("user");

    public final StringPath authorization = createString("authorization");

    public final StringPath email = createString("email");

    public final StringPath id = createString("id");

    public final NumberPath<Long> number = createNumber("number", Long.class);

    public final StringPath photo = createString("photo");

    public QUser(String variable) {
        super(User.class, forVariable(variable));
    }

    public QUser(Path<? extends User> path) {
        super(path.getType(), path.getMetadata());
    }

    public QUser(PathMetadata<?> metadata) {
        super(User.class, metadata);
    }

}

