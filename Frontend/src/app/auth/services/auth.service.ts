import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { ApiResponse } from '../../Shared/models/api-response.model';
import { Observable } from 'rxjs';
import { User } from '../../Shared/models/user.model';
import { ToastrService } from 'ngx-toastr';
import { tap } from 'rxjs/operators';
import { json } from 'stream/consumers';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  baseUrl = `${environment.apiURL}/auth`;

  constructor(private http: HttpClient, private toastrService: ToastrService) {}

  login(user: User): Observable<ApiResponse<any>> {
    return this.http
      .post<ApiResponse<any>>(this.baseUrl + '/sign_in', {
        email: user.email,
        password: user.password,
      })
      .pipe(
        tap((res: ApiResponse<any>) =>
          localStorage.setItem('uid', res.data.uid)
        ),
        tap(() =>
          this.toastrService.success('Logged in successfully', 'Login success')
        )
      );
  }

  register(user: User): Observable<any> {
    return this.http.post<any>(this.baseUrl, {
      name: user.name,
      email: user.email,
      password: user.password,
      password_confirmation: user.password,
    });
  }

  public isLoggedIn(): boolean {
    return !!localStorage.getItem('uid');
  }
}
