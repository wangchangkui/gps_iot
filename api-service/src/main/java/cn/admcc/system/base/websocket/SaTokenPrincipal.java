package cn.admcc.system.base.websocket;

import lombok.NonNull;

import javax.security.auth.Subject;
import java.security.Principal;

/**
 * @author coder wang
 * @version 1.0.0
 * @description
 * @createTime 21:04
 */
public record SaTokenPrincipal(String name, String token) implements Principal {


    @Override
    public String getName() {
        return name;
    }


    @Override
    @NonNull
    public String toString() {
        return "SaTokenPrincipal{name='" + name + "', token='" + (token != null ? "***" : "null") + "'}";
    }

    @Override
    public boolean implies(Subject subject) {
        return Principal.super.implies(subject);
    }
}
