<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;
use Validator;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index($user_id)
    {
        $user = User::find($user_id);
        if (Auth::check() && $user) {
            if ($user->username == Auth::user()->username) {
                return view('user.profile', $user);
            }
        }
        return redirect('/');
    }

    public function update(Request $request)
    {
        $messages = [
            'current_password.required' => 'La contraseña no puede estar vacía',
            'new_password.required' => 'La nueva contraseña no puede estar vacía',
            'new_password.min' => 'El tamaño mínimo de la contraseña es de 5 caracteres',
            'new_password.max' => 'El tamaño máximo de la contraseña es de 255 caracteres',
        ];

        $validator = Validator::make($request->all(), [
            'current_password' => 'required',
            'new_password' => 'required|string|min:5|max:255',
        ], $messages);

        if ($validator->fails()) {
            return redirect('user/profile/'.Auth::user()->id)->withErrors($validator);
        }
        if (request('new_password') != request('confirm_new_password')) {
            return redirect('user/profile/'.Auth::user()->id)->withErrors([
                'confirm_new_password' => 'Las contraseñas no son iguales',
            ]);
        }
        if (!Hash::check(request('current_password'), Auth::user()->password)) {
            return redirect('user/profile/'.Auth::user()->id)->withErrors([
                'current_password' => 'Contraseña incorrecta',
            ]);
        } else {
            $user = User::find(Auth::user()->id);
            $user->password = Hash::make(request('new_password'));
            $user->save();
            return redirect()->back()->with('success', 'Contraseña actualizada');
        }
    }
}
