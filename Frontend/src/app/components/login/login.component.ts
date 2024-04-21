import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { plainToClass } from 'class-transformer';
import { takeUntil } from 'rxjs/operators';
import { AuthService } from '../../auth/services/auth.service';
import { User } from '../../Shared/models/user.model';
import { subscribedContainerMixin } from '../../Shared/subscribedContainer.mixin';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent
  extends subscribedContainerMixin()
  implements OnInit
{
  public loginForm: FormGroup;

  constructor(
    private authService: AuthService,
    private formBuilder: FormBuilder,
    private router: Router,
  ) {
    super();
    this.loginForm = this.formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });
  }

  ngOnInit(): void {
    if (this.authService.isLoggedIn()){
      this.router.navigate(['/']);
    }
  }

  login(): void {
    if (this.loginForm.valid) {
      const user = {
        email: this.loginForm.value.email,
        password: this.loginForm.value.password,
      };
      const mapperUser = plainToClass(User, user);
      this.authService
        .login(mapperUser)
        .pipe(takeUntil(this.destroyed$))
        .subscribe((res) => {
          if (res && res.data.uid) {
            this.router.navigate(['home']);
          }
        });
    }
  }

  gotToRegister(): void {
    this.router.navigate(['register']);
  }

  public getEmailErrorMsg(): string {
    if (this.loginForm.controls.email.errors.required) {
      return 'Email is required.';
    } else {
      return 'Email must be a valid email address.';
    }
  }

  public getPasswordErrorMsg(): string {
    if (this.loginForm.controls.password.errors.required) {
      return 'Password is required.  ';
    } else {
      return 'Password must be longer than 7 characters.';
    }
  }
}
