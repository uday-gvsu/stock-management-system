import { Component } from '@angular/core';
import { AuthService } from './auth/services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'PortfolioManagementSystemApp';
  public isLoggedIn: boolean = this.authService.isLoggedIn();

  constructor(private authService: AuthService, private router: Router) {}

  logout() {
    if (this.authService.isLoggedIn()) {
      localStorage.removeItem('uid');
      this.router.navigate(['/login']);
    }
  }
}
